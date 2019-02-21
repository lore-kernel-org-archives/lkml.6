Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA55F20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="f6Cl7uIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBUXSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:18:50 -0500
Received: from mail-eopbgr710108.outbound.protection.outlook.com ([40.107.71.108]:15058
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726123AbfBUXSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZqjwqkuwRJdv50Cr1P0YbaskgNK0/UnBA8i3cgpHIQ=;
 b=f6Cl7uIFVPVwcwH39OL8Mx2S969N3Ld/Fk+nDme6n9czVVeaKJywbIi8hUDNxMYIWCztR0GCcMrL/AeCuLz/VNLleCpSycjfs29cHE0oyvGrpVZv8qhrWCsSQIqHyZ/WmjyYWXQaQHMuYtWz1Q4wbJvU2QzDSTHqtTvrgqT7PCE=
Received: from SN2PR01CA0055.prod.exchangelabs.com (2603:10b6:800::23) by
 BYAPR01MB5605.prod.exchangelabs.com (2603:10b6:a03:127::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 21 Feb 2019 23:18:44 +0000
Received: from CO1NAM03FT063.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by SN2PR01CA0055.outlook.office365.com
 (2603:10b6:800::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.19 via Frontend
 Transport; Thu, 21 Feb 2019 23:18:44 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT063.mail.protection.outlook.com (10.152.81.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.13 via Frontend Transport; Thu, 21 Feb 2019 23:18:43 +0000
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x1LNIeui009810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Feb 2019 18:18:41 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DB5847A3F9E; Thu, 21 Feb 2019 18:18:39 -0500 (EST)
Date:   Thu, 21 Feb 2019 18:18:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Message-ID: <20190221231839.GH10245@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB38409DE458C09B046CDED5DEE47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840AB9AD3865DA9F3FD2EF8E47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190221003221.GA4062@mit.edu>
 <VI1PR0702MB3840776AF85EE4FFAFBFC48AE47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3840776AF85EE4FFAFBFC48AE47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(39860400002)(376002)(2980300002)(189003)(199004)(305945005)(42186006)(16586007)(186003)(6916009)(8676002)(336012)(36756003)(246002)(86362001)(50466002)(5660300002)(229853002)(316002)(26005)(8936002)(52956003)(36906005)(476003)(75432002)(1076003)(2616005)(786003)(88552002)(446003)(23726003)(11346002)(478600001)(2906002)(103686004)(26826003)(33656002)(356004)(6266002)(90966002)(126002)(106002)(14444005)(4326008)(97756001)(6246003)(106466001)(486006)(93886005)(54906003)(46406003)(47776003)(76176011)(58126008)(18370500001)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB5605;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d26c1c76-71c1-4cd2-9a9c-08d69852ec41
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BYAPR01MB5605;
X-MS-TrafficTypeDiagnostic: BYAPR01MB5605:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB5605;20:nkXUJZjIliSF13cDWulWt2vVEOhxJPLPvzrwyQEAqjcOPtDigPjpc+mBPzUptSLZpJALmrxgoqHN5cNlrazjXl8xvd003D0wrTYCz5OYN2UTfuqtlDXEozVutFCCt7/jN6Vi6WG46owPpSlJtqT+PUZOOVxQFxi2KulpSRay2yPZV9oruH0rNHNUhhg2oLu1l+noM1tj9tRDX3KQ0roxsxnx33HnqRJp48lVqzD35Msaf3IXs5rjKg1SXDihInKJ2X29HWaxW5yRFBU9bf1Ii6RtUTwYwg9Q+r4E4/2AM4VQv71PGd4Bj8oR5PUIzt7uuv9twWjlF/xXud0XI74jCpTpieycVDMZnmwUFV7lEUGXAx9X4tgIze3IGlncmP1mvg/mZpbH12OL9VREOZR7JNLwkA23NFMGKLVNEeglC7A/nN+ppn71bh4I/CtkRLkLjFWBcKRImMP6OmTDzMor2mqfuRB7Q5zvg7q1j3wB+0ShlFt/rkycK+VZjOFDRtGRbR7iybiIDjsSlRXjl+nr3wvwFZ7cYXUSrxQvmcowJ7o2aaaysmFKmEgIgOxEMfJ2d28NTtc10KZOvIfM5RlgBa8yYxKs2Z/pIMvkfkI2eOo=
X-Microsoft-Antispam-PRVS: <BYAPR01MB5605A54DF41AB1D82BB8738DB57E0@BYAPR01MB5605.prod.exchangelabs.com>
X-Forefront-PRVS: 09555FB1AD
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR01MB5605;23:16HCdtKxJrINnLC8KvCn/vPLE4nADT5FL40MpQciU?=
 =?us-ascii?Q?F0FnKgnIsY+x2V26rDTEF+vd/TbDBwjKFY+TZq+Memh/a+ML5TPCVvm9aYpC?=
 =?us-ascii?Q?IFlZIg3ePkIiS+p5EgoYyrTY4LTS0h6cm+Ez7BI/NsyLGQjqpZWQqUHz9Vg9?=
 =?us-ascii?Q?hXYS0wq56Ba7rpXYJKzYXbVfnU+tBnXm+NgKNds/V+8lBN6v+i14Hki7Zz/Y?=
 =?us-ascii?Q?scHvUMinAt82LyEGSFV3uJjQJKRQzhUxwG1rM2B3VSIZafWFZV7ANrTGQ6N9?=
 =?us-ascii?Q?HLtgEeFpk9N1P3aEjKXcBQY95LlyYyN8qR/xq43weWamtVbY+wNIpyBTiTr9?=
 =?us-ascii?Q?McN6HmrlCsysvmF/PbJOa30RTsn8n0eMyq8r2f3Pss0RhImWvTOEkgvo6sWu?=
 =?us-ascii?Q?gimYg9YXgNft0dNtu5GSJkW0De6dd6fskIZgvaPIDYMOqzZc9WKllKDccUZp?=
 =?us-ascii?Q?bXo2sMD1bRXDAdHjfpez1fpaShyLTNPDUOCDu+/nybBHeLzycz+l2sWeTjiA?=
 =?us-ascii?Q?cvSIYDaOsxOzTismBpCW6Jy4MeYX8vusGP45OiIMeLVw5WBTvbFuh5BlBthA?=
 =?us-ascii?Q?nhzH6E5obPIdxToYB76PCXqjjzuMUqIHb9qj/pMO6tzMDcbSpHhgqLriKrNN?=
 =?us-ascii?Q?wrmibk5xvgJXqDTYS9WaNw72k9LOzwKHyt3JP5Kt9jOv9bpEdnRrVlfV/zVl?=
 =?us-ascii?Q?JyDbF54Sh4nBw0Ofnu6bPwXl2FqcwaK1+p3DCboOBaufdhuD3j910rBr9QIV?=
 =?us-ascii?Q?2xrXsNR2q021ficDIpCwIsnrWPHYNAAvRIThZ7K9XP07VXzS+wKExuqQmGix?=
 =?us-ascii?Q?VuyeCskVQix7a+3i3ZwtXoqxlOOSo0kMFSDexa0Ek3XLHNKLR5SBLPG6Pjrd?=
 =?us-ascii?Q?OtxBKgbglkUiMjUYSLU6vQaPP4eyW7htNK1plN1UD2dMCADc3hupPjNB70is?=
 =?us-ascii?Q?6gv1NbkwFMrjmmDVmOtIkTtLk1NLaeI2bOrCKGS+jI3g2zo9AeQkPFMm1j2K?=
 =?us-ascii?Q?G1BZwtHQELSsiFbuu39XE1F2iqgccoJogcExqd53MgjpeVZtY10AoimCV0YW?=
 =?us-ascii?Q?316gQX2hOyq5+dHlw71Zkf9dfwrh4Ylv1olu2etuUMGjpqsNdlsYt2TI5S1U?=
 =?us-ascii?Q?uWdFbnJObCgxQ6f5RFSMsxW2BsSxeTBi2yTOGp+ckPe95lB/WOrWkREso+sA?=
 =?us-ascii?Q?jNUI3xaco/N05VR5ytiXl2s8IhFynC5bNNyn/STdJfxDOtxbgVE3KNpFa7Iq?=
 =?us-ascii?Q?JesC57NOWQzUaLfQRd8/LUFhxxEq7pSoU3c2QOsOZCHCo+aUHCWUzTS3gk4H?=
 =?us-ascii?B?QT09?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IlUrtwzUemPyVTTP4b5caOWwY4nCLuGSocHQzTB0xP/bKv+1oq3wSVNKz2haYAsyT4y6EjvDtobbOyEgM/FVjnqRgUjewdA0/g0b0EQ8fJwdQNG3GT71O1a1EPTBtx2NORZ2gtwH4uaU3JjBO0C/lDKrxVMt7wHQMCSTiud34D9dZhpqvre3tn4wCGFiOOjJntx8EGw9tM6HNyb7MZzwJpsfuUMRj1aDBM8QHJzymrVw85cz+LoCEwlwiYXg5nEc8UhyH7Vi2B1JUrK3GO3q91aXUHf3IKhNTNatN+xeAtCGcnrxGxwgA2Ke7PsDs+6sQ0kwBaxEKGO5umT4qGUyFhKqwzgxjyR4rSWJ7FIpiCWJkU+MmxoinmDWlacjNKHeqtzwe5I1nwl2aQ/mVVszcyOlREY0f65/q/8BDdW1rAQ=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2019 23:18:43.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d26c1c76-71c1-4cd2-9a9c-08d69852ec41
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 07:24:14PM +0000, Bernd Edlinger wrote:
> 
> My observation, with a previous attempt (v3) of my patch is that a system
> where only interrupt randomness is available it takes typically 2 minutes
> to accomplish the initial seeding of the CRNG, if from there one has to
> wait until there is 128 bit entropy in the blocking pool it will take
> much too long.  The patch was actually buggy and did only ensure 80 bits
> of entropy in the blocking pool but even that did take 6.5 minutes, which
> felt to me like an absolutely unacceptable waiting time.
> 
> Therefore I would like to keep that to 2-3 minutes that the CRNG takes
> for it's initialization.  From there I thought, even if the entroy
> in the input_pool drops to zero, the information content however is still
> there, and after adding the next 64 bits if raw entropy, it would be fine
> to extract 8 bytes form the input_pool and feed that to the
> blocking pool, that would make 6 bytes of output, which should be
> completely unpredictable, the approach taken in my v5 patch.
> If that is not good enough, maybe extract 128 bits from the urandom
> and inject that into the blocking pool without incrementing
> the blocking_pool's entropy count.

The whole premise of reading from /dev/random is that it should only
allow reads up to available estimated entropy.  I'm assuming here that
sane users of /dev/random will be reading in chunks of at least 128
bits, reading smaller amounts for, say, a 32-bit SPECK key, is not
someone who is paranoid enough to want to use /dev/random is likely to
want to do.  So what I was doing was to simply prevent any reads from
/dev/random until it had accumulated 128 bits worth of entropy.  If
the user is reading 128 bits in order to generate a 128-bit session
key, this won't actually slow down /dev/random any more that it does
today.

It will slow down someone who just wants to read a byte from
/dev/random immediately after boot --- but as far as I'm concerned,
that's crazy, so I don't really care about optimizing it.  Your
suggestion of simply not allowing any reads until the CRNG is
initialized, and then injecting 128-bits into the blocking pool would
also work, but it wouldn't speed up the use case of "the user is
trying to read 128 bits from /dev/random".  It only speeds up "read 1
byte from /dev/random".

Personally, I would generally be simply tell users, "use getrandom(2)
and be happy", and I consider /dev/random to be a legacy interface.
It's just that there are some crazy customers who seem to believe that
/dev/random is required for FIPS compliance.

So optimizing for users who want to read vast amount of data from
/dev/random is a non-goal as far as I am concerned.  In particular,
seeding the CRNG and keeping it properly reseeded is higher priority
as far as I'm concerned.  If that slows down /dev/random a bit,
/dev/random is *always* going to be slow.

> > -			struct entropy_store *other = &blocking_pool;
> > -
> > -			if (other->entropy_count <=
> > -			    3 * other->poolinfo->poolfracbits / 4) {
> > -				schedule_work(&other->push_work);
> > -				r->entropy_total = 0;
> > -			}
> > -		}
> > +		if (!work_pending(&other->push_work) &&
> > +		    (ENTROPY_BITS(r) > 6 * r->poolinfo->poolbytes) &&
> > +		    (ENTROPY_BITS(other) <= 6 * other->poolinfo->poolbytes))
> > +			schedule_work(&other->push_work);
> 
> push_to_pool will transfer chunks of random_read_wakeup_bits.
> 
> I think push_to_pool should also match this change.

I was trying to keep the size of this patch as small as practical,
since the primary goal was to improve the security of the bits
returned when reading the a 128 bit of randomness immediately after
boot.

> I like it that this path is controllable via random_write_wakeup_bits,
> that would be lost with this change.

Very few people actually use these knobs, and in fact I regret making
them available, since changing these to insane values can impact the
security properties of /dev/random.  I don't actually see a good
reason why a user *would* want to adjust the behavior of this code
path, and it makes it much simpler to reason about how this code path
works if we don't make it controllable by the user.

> > @@ -1553,6 +1548,11 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
> >  	int large_request = (nbytes > 256);
> >  
> >  	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
> > +	if (!r->initialized && r->pull) {
> > +		xfer_secondary_pool(r, ENTROPY_BITS(r->pull)/8);
> > +		if (!r->initialized)
> > +			return 0;
> 
> Did you want to do that in push_to_pool?

No, this was deliberate.  The point here is that if the blocking pool
is not initialized (which is defined as having accumulated 128 bits of
entropy once), we refuse to return any entropy at all.

> The second part of the _random_read does not match this change:
> 
>                 wait_event_interruptible(random_read_wait,
>                         ENTROPY_BITS(&input_pool) >=
>                         random_read_wakeup_bits);
>                 if (signal_pending(current))
>                         return -ERESTARTSYS;
> 
> 
> and will go into a busy loop, when
> ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits, right?

No, because what's being tested is the entropy estimate in the *input*
pool.  If there is entropy available, then xfer_secondary_pool() will
transfer entropy from the input pool to the blocking pool.  This will
decrease the entropy estimate for the input pool, so we won't busy
loop.  If the entropy estimate for the blocking pool increases to
above 128 bits, then the initialized flag will get set, and at that
point we will start returning random data to the user.

> The select is basically done here I think this should not indicate read readiness
> before the pool is initialized that is needs to be changed, right?

Yes, we should adjust random_pool so it won't report that the fd is
readable unless the blocking pool is initialized.

	 					- Ted
