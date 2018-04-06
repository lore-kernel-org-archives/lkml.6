Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeDFAXW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:23:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751179AbeDFAXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:23:21 -0400
Date: Thu, 5 Apr 2018 17:23:10 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Michael Henders <hendersm@shaw.ca>
Subject: Re: [PATCH] resource: Fix integer overflow at reallocation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180402071616.27177-1-tiwai@suse.de>
 <20180402190903.GH5743@ram.oc3035372033.ibm.com>
 <s5hefjx2vpj.wl-tiwai@suse.de>
 <s5h3709n2cw.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h3709n2cw.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18040600-0020-0000-0000-0000040EA0B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040600-0021-0000-0000-000042A2B71A
Message-Id: <20180406002310.GI5743@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804060001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 04:40:15PM +0200, Takashi Iwai wrote:
> On Mon, 02 Apr 2018 22:35:04 +0200,
> Takashi Iwai wrote:
> > 
> > On Mon, 02 Apr 2018 21:09:03 +0200,
> > Ram Pai wrote:
> > > 
> > > On Mon, Apr 02, 2018 at 09:16:16AM +0200, Takashi Iwai wrote:
> > > > We've got a bug report indicating a kernel panic at booting on an
> > > > x86-32 system, and it turned out to be the invalid resource assigned
> > > > after reallocation.  __find_resource() first aligns the resource start
> > > > address and resets the end address with start+size-1 accordingly, then
> > > > checks whether it's contained.  Here the end address may overflow the
> > > > integer, although resource_contains() still returns true because the
> > > > function validates only start and end address.  So this ends up with
> > > > returning an invalid resource (start > end).
> > > > 
> > > > There was already an attempt to cover such a problem in the commit
> > > > 47ea91b4052d ("Resource: fix wrong resource window calculation"), but
> > > > this case is an overseen one.
> > > > 
> > > > This patch adds the validity check of the newly calculated resource
> > > > for avoiding the integer overflow problem.
> > > 
> > > Should we move this check "alloc.start <= alloc.end" into resource_contains()?
> > > Doing so will catch all uses of such erroneous (overflowing) resources.
> > 
> > I thought of it, too.  OTOH, it's rather a validity check and doesn't
> > belong to resource_contains() semantics.  If the function returns
> > false, you don't know whether it's an invalid resource or it's really
> > not contained.
> > 
> > We may return an error code, but I'm not sure whether such an API
> > change is needed.  Maybe not.
> 
> FWIW, below is the revised one to move the check into
> resource_contains().
> 
> My concern is, however, that the resource validity check isn't a job
> of resource_contains().  OTOH, this may avoid other similar cases, so
> it might be worth.
> 
> In anyway, if there is no objection, and anyone else doesn't want to
> take, I'll forward this to Andrew as a poor orphan kid.

I will stand by you as a poor-orphan-buddy. :-) 

Reviewed-by: Ram Pai <linuxram@us.ibm.com>

RP

> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH v2] resource: Fix integer overflow at reallocation
> 
> We've got a bug report indicating a kernel panic at booting on an
> x86-32 system, and it turned out to be the invalid resource assigned
> after reallocation.  __find_resource() first aligns the resource start
> address and resets the end address with start+size-1 accordingly, then
> checks whether it's contained.  Here the end address may overflow the
> integer, although resource_contains() still returns true because the
> function validates only start and end address.  So this ends up with
> returning an invalid resource (start > end).
> 
> There was already an attempt to cover such a problem in the commit
> 47ea91b4052d ("Resource: fix wrong resource window calculation"), but
> this case is an overseen one.
> 
> This patch adds the validity check in resource_contains() to see
> whether the given resource has a valid range for avoiding the integer
> overflow problem.



> 
> Bugzilla: https://urldefense.proofpoint.com/v2/url?u=http-3A__bugzilla.opensuse.org_show-5Fbug.cgi-3Fid-3D1086739&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=m-UrKChQVkZtnPpjbF6YY99NbT8FBByQ-E-ygV8luxw&m=NNkNAWFZc1XRu3rkv7Y2sepSCe8re2cvNZuCJt5dWFE&s=7i3g3ZVYsUceGVK_ZKkCJIABp4l0RD59NelK3GoD8mI&e=
> Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
> Reported-and-tested-by: Michael Henders <hendersm@shaw.ca>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/linux/ioport.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..466d7be046eb 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -212,6 +212,9 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
>  		return false;
>  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
>  		return false;
> +	/* sanity check whether it's a valid resource range */
> +	if (r2->end < r2->start)
> +		return false;
>  	return r1->start <= r2->start && r1->end >= r2->end;
>  }
>  
> -- 
> 2.16.3

-- 
Ram Pai
