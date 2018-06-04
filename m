Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeFDJq1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:46:27 -0400
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:10813 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeFDJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:46:26 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'tj@kernel.org'" <tj@kernel.org>
CC: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: RE: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Topic: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
Thread-Index: AdP2gtQcFftKX6rKRguW2o+iRXsAXgAm4bKAAJr88AD//+p/gP/7MDrw
Date: Mon, 4 Jun 2018 09:46:17 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B65E08B@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
 <20180529162627.GH1351649@devbig577.frc2.facebook.com>
 <33710E6CAA200E4583255F4FB666C4E21B65779C@G01JPEXMBYT03>
 <20180601170717.GY1351649@devbig577.frc2.facebook.com>
In-Reply-To: <20180601170717.GY1351649@devbig577.frc2.facebook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: a0eb8eb1e96e46dfb0d5c10c9d2c8f0d
x-originating-ip: [10.124.89.120]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of 'tj@kernel.org'
> Sent: Saturday, June 2, 2018 2:07 AM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>; Okajima,
> Toshiyuki <toshi.okajima@jp.fujitsu.com>;
> linux-kernel@vger.kernel.org; 'ebiederm@aristanetworks.com'
> <ebiederm@aristanetworks.com>
> Subject: Re: [RESEND PATCH v2] kernfs: fix dentry unexpected skip
> 
> Hello,
> 
> On Fri, Jun 01, 2018 at 09:25:32AM +0000, Hatayama, Daisuke wrote:
> > kernfs_dir_pos() checks if a kernfs_node object given as one of its
> > arguments is still active and if so returns it, or returns a
> > kernfs_node object that is most equal (possibly smaller and larger) to
> > the given object.
> 
> Sometimes they're duplicate operations tho, which is exactly the bug
> the posted patch is trying to fix.  What I'm suggesting is instead of
> leaving both instances and skipping one conditionally, put them in one
> place and trigger only when necessary.  The sequence of operations
> would be exactly the same.  The only difference is how the code is
> organized.
> 

I see and I think Eric's patch is written as you suggest very well.

> > kernfs_dir_next_pos() returns a kernfs_node object that is next to the
> > object given by kernfs_dir_pos().
> >
> > Two functions does different things and both need to skip inactive
> > nodes. I don't think it natural to remove the skip only from
> > kernfs_dir_pos().
> >
> > OTOH, throughout getdents(), there is no case that the kernfs_node
> > object given to kernfs_dir_pos() is used afterwards in the
> > processing. So, is it enough to provide kernfs_dir_next_pos() only?
> > Then, the skip code is now not duplicated.
> >
> > The patch below is my thought. How do you think?
> >
> > But note that this patch has some bug so that system boot get hang
> > without detecting root filesystem disk :) I'm debugging this now.
> 
> I haven't looked into the code that closely but given that we had
> cases where both skippings were fine and not, the condition is likely
> gonna be a bit tricker?

I agree to this version looks a bit tricker. But I think once the skipping
code is separated as Eric's patch, it would be resolved naturally.

> 
> Thanks.
> 
> --
> tejun
> 
