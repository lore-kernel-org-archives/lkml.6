Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756924AbeDBTJR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:09:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756743AbeDBTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:09:14 -0400
Date: Mon, 2 Apr 2018 12:09:03 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Michael Henders <hendersm@shaw.ca>
Subject: Re: [PATCH] resource: Fix integer overflow at reallocation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180402071616.27177-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402071616.27177-1-tiwai@suse.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18040219-0008-0000-0000-000004E5D717
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040219-0009-0000-0000-00001E78DE5A
Message-Id: <20180402190903.GH5743@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 09:16:16AM +0200, Takashi Iwai wrote:
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
> This patch adds the validity check of the newly calculated resource
> for avoiding the integer overflow problem.

Should we move this check "alloc.start <= alloc.end" into resource_contains()?
Doing so will catch all uses of such erroneous (overflowing) resources.

RP

> 
> Bugzilla: https://urldefense.proofpoint.com/v2/url?u=http-3A__bugzilla.opensuse.org_show-5Fbug.cgi-3Fid-3D1086739&d=DwIBAg&c=jf_iaSHvJObTbx-siA1ZOg&r=m-UrKChQVkZtnPpjbF6YY99NbT8FBByQ-E-ygV8luxw&m=FoiwlR-LTJ9_EBQsLYSCqXuWrGhU1lXycdvhbaK7wOk&s=clxOtFUIAMlPNwQJZTaKnmIta9pMtJ8XprmwVd-ylvo&e=
> Fixes: 23c570a67448 ("resource: ability to resize an allocated resource")
> Reported-and-tested-by: Michael Henders <hendersm@shaw.ca>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> Bjorn, I send this to you since the bug hits during PCI init, although
> the culprit is in generic resource management.
> 
>  kernel/resource.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index e270b5048988..2af6c03858b9 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -651,7 +651,8 @@ static int __find_resource(struct resource *root, struct resource *old,
>  			alloc.start = constraint->alignf(constraint->alignf_data, &avail,
>  					size, constraint->align);
>  			alloc.end = alloc.start + size - 1;
> -			if (resource_contains(&avail, &alloc)) {
> +			if (alloc.start <= alloc.end &&
> +			    resource_contains(&avail, &alloc)) {
>  				new->start = alloc.start;
>  				new->end = alloc.end;
>  				return 0;
> -- 
> 2.16.2

-- 
Ram Pai
