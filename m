Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/4W0axHvSNz1k+C0JZ+49M2jW4y6nlTuRjAmIwMAYO+xoIJqCMbLDsi91BZUKICs/xEzPj
ARC-Seal: i=1; a=rsa-sha256; t=1522348566; cv=none;
        d=google.com; s=arc-20160816;
        b=O7nu3A3jyo4KQ73F9jwS6s55iqNJMQpRUEBSN8gv/S6YGOW1E7TMKP2kJ241GEVLpP
         A726tJS040Zw/BRNwDEe5fLObEIVxhBGmwhbTKpnQIyHrLMngLMUoVzC81VtL1651Q70
         OibDB6e794Khw0K/L7RH/78kzpSGrc4ymLppVydEnEjzUwd0mQWZcXQSkjWyBbqyG5Ss
         tmDv3/7EcBabse0onIOPzTMAdN+6nNUMFbFnKe4xF07GDoYfCUs6YlHEznxlEfhKKz6r
         Fn8XnwnrQdeI1SAFaQJr26+RNoSRV7N12wtexpqxWKweq8CsDnIsk3WZ7C7qkGY+19pr
         7BzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=6OfFRvjNsSXSK9DQZqrOi6hRtf+m8OcJe7xjzKAfwdA=;
        b=an6RSpXYVEXXTJIA9nvHLE99Ur0Lzk1PF+IfaR9dDjCInpiF0oSrNleRCSixprLFas
         igJf0EMZBGQ0igeviOTPwkpEDlhLmgFv00G74Q04eCkzJtjj9winzIs7JxQKI6S5clzC
         fqoPFvL5/JPycyLWdZYbP+W8GXpOnPesgLASsVltdcECCwIwksiX+LJijbpsjzBq+SqT
         R30Ru4fbnGh3zkAvZpytKAJRwEe5QKYiG2JN5ErYXaVubyV7rpkQlUWLoPSu5KmaNyBe
         ZKQP8CiNqxn8y/YIOQSu/1jJyLxu5ddHA3ogFttXnpc6NcZ9Li17LFOl+aZIy3/IErvN
         6tsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DPBA458o;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.104 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DPBA458o;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.104 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Josef Bacik <josef@toxicpanda.com>
CC: "Luis R. Rodriguez" <mcgrof@kernel.org>, Dave Chinner
	<david@fromorbit.com>, Sasha Levin <levinsasha928@gmail.com>, "Darrick J.
 Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@lst.de>, xfs
	<linux-xfs@vger.kernel.org>, "linux-kernel@vger.kernel.org List"
	<linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>, Josh
 Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>, Michal Hocko
	<mhocko@kernel.org>, Joerg Roedel <joro@8bytes.org>, Anna Schumaker
	<Anna.Schumaker@netapp.com>, Tso Ted <tytso@mit.edu>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAc86AIABC40AgAA8N4CAAUBqgIAAAVmAgAAFQYA=
Date: Thu, 29 Mar 2018 18:36:04 +0000
Message-ID: <20180329183601.GD7561@sasha-vm>
References: <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia> <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard> <20180328193004.GB7561@sasha-vm>
 <20180328230535.GE18129@dastard> <20180329181223.GK30543@wotan.suse.de>
 <20180329181712.ijbruc7rl2i3nh35@destiny>
In-Reply-To: <20180329181712.ijbruc7rl2i3nh35@destiny>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0904;7:yZbxREl6sVxkAANIQIAV6jWeQx/GWdYLnLbc/iUoHZmCK4yiOip39I2cCpQXzsaSdXM+dmdBNTxbh7v3iCOGHwAjScBh5IMLUixlCudvHm9dddC56/hyg+RJm0G0Oshm4CEFR+yVmmY/ZrH/QvswJeg2MCXf0cuhrrndV4qPiA6TTxYkel+8R/SXBY6jd3l+T6sozTygYLmTGUVmA6XNuEoaTcQAlMDGkRniq4uNOYQu7Zq5r7IsTH8ai/w8Oqf8;20:OGPRkDl0kpuE+m2vcRv8OQnlJ9vuSBGw0mvYzqwFfJo8m30IneAAOCDqWnlsLoXVhSvP2NOHZ7yyi+ndPcvG5Yasf0TdtLOmv24ZC1JaDA+rnCooF1Q0jXlRvOpRo5WqRH9KKl6N0RZWcvbfj/vlNXSHeiOO6jwUVpxyPZURmdE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de33fe98-f30c-4931-1287-08d595a3ee0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0904;
x-ms-traffictypediagnostic: DM5PR2101MB0904:
x-microsoft-antispam-prvs: <DM5PR2101MB0904DA7A296AC8EF2C4BFD24FBA20@DM5PR2101MB0904.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(20558992708506);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0904;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0904;
x-forefront-prvs: 0626C21B10
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(366004)(39860400002)(39380400002)(396003)(189003)(199004)(8936002)(81156014)(66066001)(102836004)(81166006)(72206003)(9686003)(5250100002)(22452003)(68736007)(229853002)(6246003)(6436002)(25786009)(6512007)(54906003)(6486002)(7416002)(33656002)(3660700001)(105586002)(53936002)(14454004)(6916009)(1076002)(478600001)(106356001)(6346003)(305945005)(26005)(186003)(6116002)(3846002)(3280700002)(486005)(486005)(39060400002)(33716001)(2906002)(476003)(2900100001)(4326008)(446003)(10090500001)(8676002)(11346002)(316002)(86362001)(86612001)(7736002)(97736004)(59450400001)(5660300001)(99286004)(6506007)(33896004)(10290500003)(93886005)(76176011)(31884003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0904;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 4cYIy5w1VkpKUmsaRy4/fmsSpO6btCZoAhPO7ggzuilxRJxBp88L67H/vopZOPBwfEVe+rrxsqpWYlkxCJERGI/Rsono+rMbewy2mC9UTv7EcPbAtzUxG/PSA6DFQXU+Bou62qGpSAZ+UlqJQieGuaJ+EXT1XX63haaetaQLqRiKp/RcHIrYBWS5EShMRfOeAaEUnp87zHI8eLlqvmbquNktLex5acjlNQRfSplxgu4tUqXziN/8QRp1zH8sCEaF79BBK3ir2SCzI61/zXsAxA8UhiGgEANpPYx7s/L0V1O8GuKCfi7OA5hJXAAQSdls7Gj0Ioa4m2uuF2SgK/AAIg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C34FFD362AE0C43A41685263EB61DDC@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de33fe98-f30c-4931-1287-08d595a3ee0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2018 18:36:04.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0904
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596298170861079505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 02:17:13PM -0400, Josef Bacik wrote:
>On Thu, Mar 29, 2018 at 06:12:23PM +0000, Luis R. Rodriguez wrote:
>> On Thu, Mar 29, 2018 at 10:05:35AM +1100, Dave Chinner wrote:
>> > On Wed, Mar 28, 2018 at 07:30:06PM +0000, Sasha Levin wrote:
>> > >
>> > > This is actually something I want maintainers to dictate. What sort =
of
>> > > testing would make the XFS folks happy here? Right now I'm doing
>> > > "./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you=
'd like to see?
>> >
>> > ... and you're doing it wrong. This is precisely why being able
>> > to discover /exactly/ what you are testing and being able to browse
>> > the test results so we can find out if tests passed when a user
>> > reports a bug on a stable kernel.
>> >
>> > The way you are running fstests skips more than half the test suite
>> > It also runs tests that are considered dangerous because they are
>> > likely to cause the test run to fail in some way (i.e. trigger an
>> > oops, hang the machine, leave a filesystem in an unmountable state,
>> > etc) and hence not complete a full pass.
>> >
>> > "./check -g auto" runs the full "expected to pass" regression test
>> > suite for all configured test configurations. (i.e. all config
>> > sections listed in the configs/<host>.config file)
>>
>> ie, it would be safer to expect that an algorithmic auto-selection proce=
ss for
>> fixes for stable kernels should have direct input and involvement from
>> subsystems for run-time testing and simply guessing or assuming won't su=
ffice.
>>
>> The days of just compile testing should be way over by now, and we shoul=
d
>> expect no less for stable kernels, *specially* if we start involving
>> automation.
>>
>> Would a way to *start* to address this long term for XFS or other filesy=
stems
>> for auto-selection long-term be a topic worth covering / addressing at L=
SF/MM?

If this is something the FS/MM folks would like to discuss I'd be happy
to attend. I do plan on pushing this to other subsystems (and given that
I'd support xfstests, fs/ is a good candidate) once the infrastructure +
XFS specific stuff is done (hopefully later today).

>It would be cool to tie tests to commit numbers for things where we're mak=
ing
>sure a oops/hang doesn't happen again, but honestly I'm not sure it's wort=
h the
>effort.  Maybe this is my upstream bias showing, but I only ever run xfste=
sts
>against something relatively close to linus, so I'm not super worried abou=
t
>./check -g auto eating my box.  I expect that if I run auto that everythin=
g
>minus the few flakey tests are going to pass.
>
>Also TIL about configs/<host>.config, that's pretty fucking cool.  Thanks,

On the other hand, from all the customers I've seen, none run anything
"close" (<3 months delta?) from Linus. The "good" ones run 4.15.y, the
worst are probably 4.1.y for upstream and the 2.6.32 RHEL ones.

So while making upstream bug-free is important, no one is actually using
that code :)

By the time those customers end up using a 4.16 kernel, for example,
they'll get all the fixes you're pushing in now, but they'll also be
stuck with the new bugs that slipped in.

Either way, I've integrated xfstests to run the way Derrick and Dave
recommended for every stable tree that I'm considering a backport of a
patch to, I'll send another mail later today once I wrap it up.

--
Thanks,
Sasha=
