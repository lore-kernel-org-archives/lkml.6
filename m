Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+r8WADHmcfp4ZLEdLqLGvRPQ0LsCiJN47NFhwsx2fggmtAVNk/ZH2tABHMChx8UiOrSoxr
ARC-Seal: i=1; a=rsa-sha256; t=1522378028; cv=none;
        d=google.com; s=arc-20160816;
        b=Ip3Osn6pFr9jkM5NTjP1TAcv1Xe/wiVGAFYUnP84Gyjf38xbRUeFiIY1koRtN7ua6v
         8s8fk1kaItQD97G8zoFN4tYvA9rDWs6z7MxLD5O25Y8JBHJZhxoCa9yqFbM5fmJhwffQ
         /lVNdMGLFsQwW+JSoWWIo299WfCB3rVQkMJfdyuGu00RikSsSqWBL0htPCn7F/NfaLaH
         +fOv5N4W+7Mn1DD1hRUAiU4UmoC+y8+MUTXi+JuMOnXmKD2erEIGaNxO5PcZ3cbSaCZ6
         blbjZN8vvFFgdk4dfObimE9okTpiNcU6/XY0EiHf+FW0+MhRxvKNXkFKRZRQQ+jwg3zU
         v+uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ACJsy1edyahh9mNyvvV8FNzUkMg72yd+GzKbDtrWfsQ=;
        b=Pj6flOp/Lm98wTCb0zS7EmsTTIeImye20oFwIGaYF2AR9Qe2aHiTDpu745NeSu5ET8
         uC0fUNUFqCTah/hbi1r86IrK080CljFpMLX6Ew9aupKJW8NGm/T9rxKg2JspneSp164v
         CelC2Doaw2y9O5PmD7MtNbYhNwWNQBYKGyAMwg34rDEgVnd//nHfs3b7Fmv4fhRerBzJ
         9AG124bL6UDeSupCSCnMS+T6KB0PPwwYaxAcdJcoM+14t4Bryx+5i5a0sKatFNvorx9k
         LkW75jbuzlC7MS0i5QAwlqTkcXHl9t3cS/0cNcClQvCTGD5OEZdhVJBW3Jjg2Ym1h+vE
         4gbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aMLxGTdt;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=aMLxGTdt;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.38.102 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Dave Chinner <david@fromorbit.com>
CC: Sasha Levin <levinsasha928@gmail.com>, "Luis R. Rodriguez"
	<mcgrof@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph
 Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall
	<julia.lawall@lip6.fr>, Josh Triplett <josh@joshtriplett.org>, Takashi Iwai
	<tiwai@suse.de>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel
	<joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAc86AIABC40AgAA8N4CAAdA3AA==
Date: Fri, 30 Mar 2018 02:47:05 +0000
Message-ID: <20180330024704.GE7561@sasha-vm>
References: <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia> <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia> <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard> <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard>
In-Reply-To: <20180328230535.GE18129@dastard>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;7:4xx0K4Kggqbu+9hdlNnAaz1g2Hj2HxaiE8/qyi2bPkWNupcpbUkZGHZxg0C+Ekftx28jU0dBti5CLMGnN0m+7AZDqwWIDqLQs8Jc81mKWuen7QCdg4AwgYGdfHV3G0dBf2jaMlXGds5jagJc1mYa7S3D9JaYW+6V8g+ooRIAzBK4IAHyqCQHxg/bF33SObGhOptStV4tqN67akBNIrZFVefkwvoKHj5+weUCsKW5hgZxAFZ8xH0eRKRe94XkkPhd;20:DvTgJQGfPn7fUeU+CVfaYWSFQ8PCdGbWBo1rP2YzHDwUDvO/Xru/xfMn3R+LWW7JjTVBnmLRYVM5ACsy2MgHdNvZJqamkS+qTiI4oRSArm32TGGAJCWUSD44zbrCN/R8LAKWdVFdYAViSGGB+FhR7cfPvuzr3B7CpadkIBOSS54=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c5cc80cd-0e80-4f9c-7882-08d595e88679
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB10654E68F56743111859606EFBA10@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(9452136761055)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 06274D1C43
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(376002)(39380400002)(346002)(396003)(366004)(199004)(189003)(25786009)(76176011)(446003)(93886005)(33656002)(26005)(106356001)(6116002)(3846002)(66066001)(316002)(478600001)(22452003)(486005)(486005)(102836004)(10290500003)(4326008)(3660700001)(6246003)(68736007)(476003)(72206003)(6506007)(86362001)(186003)(11346002)(14454004)(33716001)(99286004)(33896004)(53936002)(5250100002)(105586002)(6512007)(9686003)(7736002)(6306002)(54906003)(305945005)(229853002)(3280700002)(2906002)(97736004)(39060400002)(86612001)(8936002)(6916009)(1076002)(6486002)(5660300001)(81156014)(81166006)(6436002)(2900100001)(8676002)(7416002)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: kuu7UC4JlaY1N0CdBkhF+tCwnXVg6yj+CBdJ05EnM0Ag47OnasHNVb1aIKb8UX1RcGpJSxtZ+8x9ZshOg5dAKME6Qzp6OxOJnhYKL30LggVaIE0Wpv9EdVjFrZzAe9K0HYiklCdSezkkYohtfTIQp93vteJTiMwX9IZBZE0JZ/tcamo34WQU5nvX3RxiNyChTQANfeZyW8DF8fu3oav9gfDZzRbbgwKQCH+8TQ41lYje6Denl/gyTD+xIkQsyHVSgQ3D39P0/Odlf80/cK0iVYP3zUzzZvlE7811m88rlbjK4t5M3T0rOl/UBOceGGydiybKY5MlqOPXCDlg8xcM1LDkuWqSb9Xjtju0n56/rSu83kTZ8aahPZ15DfSaTHxVfSSqEBq+BbNfmvmFre4H9tLxw34k99hP1OjbZ60Vl54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA5B43971A20994B9DD4C50736DDFE53@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cc80cd-0e80-4f9c-7882-08d595e88679
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2018 02:47:06.1840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596329064158153642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
>On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
>> This is actually something I want maintainers to dictate. What sort of
>> testing would make the XFS folks happy here? Right now I'm doing
>> "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd l=
ike to see?
>
>... and you're doing it wrong. This is precisely why being able
>to discover /exactly/ what you are testing and being able to browse
>the test results so we can find out if tests passed when a user
>reports a bug on a stable kernel.
>
>The way you are running fstests skips more than half the test suite
>It also runs tests that are considered dangerous because they are
>likely to cause the test run to fail in some way (i.e. trigger an
>oops, hang the machine, leave a filesystem in an unmountable state,
>etc) and hence not complete a full pass.
>
>"./check -g auto" runs the full "expected to pass" regression test
>suite for all configured test configurations. (i.e. all config
>sections listed in the configs/<host>.config file)

Great! With information from Darrick and yourself I've modified tests to
be more relevant. Right now I run 4 configs for each stable kernel, but
can add more or remove any - depends on what helps people analyse the
results.

The complete VM serial logs as well as results/ from xfstests are also
available and are linked from the email.

Here's an example of such email:

> From: Sasha Levin <alexander.levin@microsoft.com>
> To: Sasha Levin <alexander.levin@microsoft.com>
> To: linux-xfs@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.co=
m>
> Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation logi=
c
> In-Reply-To: <20180306102638.25322-1-vbendel@redhat.com>
> References: <20180306102638.25322-1-vbendel@redhat.com>
>
> Hi Vratislav Bendel,
>
> [This is an automated email]
>
> This commit has been processed by the -stable helper bot and determined
> to be a high probability candidate for -stable trees. (score: 6.4845)
>
> The bot has tested the following trees: v4.15.12, v4.14.29, v4.9.89, v4.4=
.123, v4.1.50, v3.18.101.
>
> v4.15.12: Build OK!
> v4.14.29: Build OK!
> v4.9.89: Build OK!
> v4.4.123: Build OK!
> v4.1.50: Build OK!
> v3.18.101: Build OK!
>
> XFS Specific tests:
>
> v4.15.12 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.15.12/test=
s/):
>     No tests completed!
> v4.14.29 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.14.29/test=
s/):
>     No tests completed!
> v4.9.89 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.9.89/tests/=
):
>     No tests completed!
> v4.4.123 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.4.123/test=
s/):
>     v4:
>         Thu Mar 29 21:23:57 UTC 2018
>         Interrupted!
>         Passed all 0 tests
>     v4_reflink:
>         Thu Mar 29 21:24:37 UTC 2018
>         Interrupted!
>         Passed all 0 tests
> v4.1.50 (http://stable-bot.westus2.cloudapp.azure.com/test/v4.1.50/tests/=
):
>     No tests completed!
> v3.18.101 (http://stable-bot.westus2.cloudapp.azure.com/test/v3.18.101/te=
sts/):
>     v4:
>         Thu Mar 29 21:30:40 UTC 2018
>         Interrupted!
>         Passed all 0 tests
>     v4_reflink:
>         Thu Mar 29 21:25:14 UTC 2018
>         Interrupted!
>         Passed all 0 tests
>
> Please let us know if you'd like to have this patch included in a stable =
tree.
>
> --
> Thanks,
> Sasha

Let me know if this would be good enough for now, and if there's
anything else to add that'll be useful.

This brings me to the sad part of this mail: not a single stable kernel
survived a run. Most are paniced, some are hanging, and some were killed
because of KASan.

All have hit various warnings in fs/iomap.c, and kernels accross several
versions hit the BUG at fs/xfs/xfs_message.c:113 (+-1 line)

4.15.12 is hitting a use-after-free in xfs_efi_release().
4.14.29 and 4.9.89 seems to end up with corrupted memory (KASAN
warnings) at or before generic/027.
And finally, 3.18.101 is pretty unhappy with sleeping functions called
from atomic context.

--
Thanks,
Sasha=
