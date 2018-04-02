Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+tdzju6z1/oyD+LxOp7+D0SN7gfOAolJDRbfUi1X+iKwr8zoQGXI6zqHbX/G3IupR260iJ
ARC-Seal: i=1; a=rsa-sha256; t=1522629328; cv=none;
        d=google.com; s=arc-20160816;
        b=IiC2r6FXyXd7i6iyeWnjhLbbUh4SDwJyObro9pItwi6oFrQ9QqSsaZn4k+jYC/iSI1
         G/zDgVjidSG+kVYJ74NJK6dLealx7txEVO7QuGyZZQkxZhhtemLeYf8tPWzHre2Cgjx4
         CDBFe6oV7j6nidmFFxSyc4iOWslfOasYjqTx8j5Vb8+u0Vc8GMbN4uxRqBzyXppOIWIv
         WUCk3cYQDyjzbtNbQz9LvKZ6fDZZ0oZ+kTL1Kua69olmHNSbW9jQncjEXx2dSTFm3zLj
         5qM31DH1HN8Oc3eGSbht9vQtOfZiXyKay2sXH07cNpzVk5QK1o1uI5y1o/q54rxmZHqu
         ntSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=ZQnYQRVhVpjXGgQSoMXCrh5gffY44ar6HyTOLg+8060=;
        b=Z/m/zouQnqcVHltT2WjoJ9hZhEyh6TV9zevXEO9FV4kqyZzrmWj377GXI8CBGn3eAA
         6ApTVGHn0T54J/BCPYG4hs062fihJPcjSZXSXfyeKSuzdOD5evc1VF0Ccr/lmM4hHWmr
         /1eECf9emqHm2umEJGFOW3u48NYuGCGunouooleXkTF3IBxNlNqrCJYrXWrEpuh3HLHA
         DWJ8chN43k4L1/pl/DFc4TOdiyMrytIDWL8DKh65wgeDnrwThc15dRIHL1dzjit5u1rv
         9ZD9vsYG0mDanyekY3SYDgFZr/pOIVW2kosJjNpJ0MPRqJsKYJ64GDXJ/deVoLuxIvtX
         NjDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=jR9p7T0b;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=jR9p7T0b;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
CC: Dave Chinner <david@fromorbit.com>, Sasha Levin <levinsasha928@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@lst.de>,
	xfs <linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org List"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh
 Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAc86AIABC40AgAA8N4CAAdA3AIABHb0AgAN0doA=
Date: Mon, 2 Apr 2018 00:35:25 +0000
Message-ID: <20180402003523.GG7561@sasha-vm>
References: <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia> <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard> <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard> <20180330024704.GE7561@sasha-vm>
 <20180330194946.GF9190@wotan.suse.de>
In-Reply-To: <20180330194946.GF9190@wotan.suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0806;7:et2hYSulZ8I5hgJGc9obt76iS0iHrXoYzn1Pcu064WKqu5c29p8n//k3wPdgsh43K/TDbjxEwxtCAkwIWiBQQLsp8+IwepTAJEdq69Xl3GnMGbfRYyIAHwxyy1FwreUOc1q3Ma/A7L686E46RfWnCSnbIxIKOFkbIH+fZXo9IzYyBUMceg+pQ/NZScYwgcwPcXaJ+r/MAT9fnezc71plKXPE9KJB+nNdGU6fOcY6oeb6enFOxljQ+0yaRTvvPvGM;20:ETmeKdTJWsnYWQsr5usvF9lyiwBX4bf1ICDSQV9rqyPPQxRcS5fKZOsBzP7GnTyA32t5lpwskcKkzWpfeOXSd2XF7vZJP3POwAVVDhsiH15zY7ofnOc8Ozy51swpKnvS92lDoyb0vODA1WQ8XVVBXsEH1VBkoAG0kD9G7GYSkHA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c7ba7ce-a4a3-4095-745b-08d59831a0b6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0806;
x-ms-traffictypediagnostic: DM5PR2101MB0806:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB08060E7DC00F4364121C5CB8FBA60@DM5PR2101MB0806.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0806;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0806;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(39860400002)(39380400002)(346002)(396003)(189003)(199004)(51914003)(476003)(486005)(486005)(446003)(6116002)(14454004)(86362001)(25786009)(9686003)(7416002)(93886005)(68736007)(11346002)(81156014)(6512007)(81166006)(102836004)(6486002)(72206003)(186003)(26005)(8676002)(22452003)(8936002)(53936002)(106356001)(4326008)(316002)(305945005)(5250100002)(229853002)(1076002)(3846002)(54906003)(7736002)(5660300001)(33656002)(76176011)(6246003)(39060400002)(86612001)(6916009)(2900100001)(10290500003)(3660700001)(3280700002)(478600001)(6506007)(59450400001)(33896004)(6436002)(97736004)(99286004)(10090500001)(105586002)(2906002)(66066001)(33716001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0806;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vVY0T8Jw5Mq7jpfkNHSeV1R5Mk/6wMTWhtGKwa+c61fhbd8JTLJlotCufQVo2eVbNkLo6InAjJgDRvsWIixpfVFKbe0H9IB0QqY8d2y05+r2wTATkrzXovRa88QtXgIKr4tOBqQIjjuROn58P2OAk4tMJMMkOAXxX8NuQyopYPvst1LDBWYihoN+baSnMgA9GSRT1lXExKNj22KG9fx1VvOwqaTrZv/wdTiW1VAkzr9eoahU5wnQ7aMyUwyTE25QVbJDKQ31lFCNFijvX3q/KaBDVXkhPS301CnX8ld99YlH+RkejPOOinwkmLymOm9sPz6VUwFEx1jxz6WFpPJNlbo/5SD32YGGRkWh+oxoQmvTaGp7r1dbirnz9V6RPvLp0hIzYBu6ys6+hLfM266g9lWi8eYA6K3G+S6mV44haz0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F232D384E580E34D8703968E0238C317@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ba7ce-a4a3-4095-745b-08d59831a0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 00:35:25.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0806
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596592571171616890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 07:49:46PM +0000, Luis R. Rodriguez wrote:
>On Fri, Mar 30, 2018 at 02:47:05AM +0000, Sasha Levin wrote:
>> On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
>> >On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
>> >"./check -g auto" runs the full "expected to pass" regression test
>> >suite for all configured test configurations. (i.e. all config
>> >sections listed in the configs/<host>.config file)
>>
>> Great! With information from Darrick and yourself I've modified tests to
>> be more relevant. Right now I run 4 configs for each stable kernel, but
>> can add more or remove any - depends on what helps people analyse the
>> results.
>>
>> This brings me to the sad part of this mail: not a single stable kernel
>> survived a run. Most are paniced, some are hanging,
>
>I expected this. The semantics over -g auto yielding "expected to pass"
>are relative. Perhaps its better described as "should pass"?
>
>> and some were killed
>> because of KASan.
>>
>> All have hit various warnings in fs/iomap.c, and kernels accross several
>> versions hit the BUG at fs/xfs/xfs_message.c:113 (+-1 line)
>>
>> 4.15.12 is hitting a use-after-free in xfs_efi_release().
>> 4.14.29 and 4.9.89 seems to end up with corrupted memory (KASAN
>> warnings) at or before generic/027.
>> And finally, 3.18.101 is pretty unhappy with sleeping functions called
>> from atomic context.
>
>From my limited experience you have no option but to create an expunge lis=
t for
>each failure for now, and then pass the expunge lists -- that in essence w=
ould
>define the stable baseline and you should expect this to be different per
>kernel release. If you upgrade tooling, it can also change the results, an=
d
>likewise if you upgrade fstests.
>
>If you define an expunge list you can then pass the list with the -E param=
eter,
>you can for instance categorize then failures by type and use a file for e=
ach
>type of failure, whether that's a triage list or a type of common failure.
>Format can be:
>
>test # comments are ignored
>
>Since you may want to database this somehow, perhaps a format that lists
>some tracking for it or other heuristics:
>
>generic/388 # bug#12345 - 1/300 run fails
>
>I'd recommend to just add all failures to one large expunge list for now,
>and later you can split / sort them them as needed.
>
>The idea later is that any failure later would be a regression. What would
>be good is to test a stable kernel prior to the auto-selection and use tha=
t
>as baseline, then bump the kernel and ensure no regressions were created.
>
>A dicey corner issue is that of tests which are supposed to "pass" but yet
>can fail every blue moon. For instance I've been running into one-off fail=
ures
>with generic/388 -- but only if I run it over 300 times.
>
>As such the baseline IMHO should also track these as just failures, howeve=
r it
>will be often picked up as a regression first. The only way to rule this o=
ut
>is to loop test the same test prior to a kernel update and ensure it wasn'=
t
>a regression -- ie, that it *was* still failing before.

Thanks for the pointers!

>This is why all this work is rather full time'ish. There is no way around =
it,
>it will take time to establish a baseline from fstests for a filesystem. T=
here
>will also be a lot of odd ins and outs of each filesystem.

Right, but the way I see it, no one actually uses upstream. If anything,
it's a development branch, and the "real" users pick up one of the
stable trees to work with. So while there seems to be a lot of effort
dedicated to new features or fixing upstream bugs, not enough people
care that no one won't see those fixes for a few years.


--
Thanks,
Sasha=
