Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeAaWHP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 17:07:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753395AbeAaWHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 17:07:12 -0500
Subject: Re: [RFC PATCH] rootfs: force mounting rootfs as tmpfs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Rob Landley <rob@landley.net>, initramfs <initramfs@vger.kernel.org>
Cc: Taras Kondratiuk <takondra@cisco.com>,
        Victor Kamensky <kamensky@cisco.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 31 Jan 2018 17:07:03 -0500
In-Reply-To: <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
References: <1517348777.3469.5.camel@linux.vnet.ibm.com>
         <1814af5c-170d-39c0-58fd-02eb7216e008@landley.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18013122-0008-0000-0000-000004C81937
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013122-0009-0000-0000-00001E5BB4E9
Message-Id: <1517436423.3469.237.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-31_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801310275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 13:32 -0600, Rob Landley wrote:
> On 01/30/2018 03:46 PM, Mimi Zohar wrote:
> > Commit 16203a7a9422 ("initmpfs: make rootfs use tmpfs when CONFIG_TMPFS
> > enabled") introduced using tmpfs as the rootfs filesystem.  The use of
> > tmpfs is limited to systems that do not specify "root=" on the boot
> > command line.
> > 
> > Without the check "!saved_root_name[0]", rootfs uses tmpfs.  As there
> > must be a valid reason for this check, this patch introduces a new boot
> > command line option named "noramfs" to force rootfs to use tmpfs.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> How about just:
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 7cf4f6d..af66ede 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -632,8 +632,8 @@ int __init init_rootfs(void)
>  	if (err)
>  		return err;
> 
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs"))) {
> +	if (IS_ENABLED(CONFIG_TMPFS) && (!saved_root_name[0] ||
> +		!strcmp(saved_root_name, "tmpfs"))) {
>  		err = shmem_init();
>  		is_tmpfs = true;
>  	} else {
> 
> (Obviously-signed-off-by: Rob Landley <rob@landley.net>)
> 
> I.E. if you somehow just can't stop yourself from specifying root= when
> using rootfs, have "root=tmpfs" do what you want.

I tried overloading "rootfstype=tmpfs", before posting this work
around, but for some reason that just doesn't work.

> 
> (The old "I configured in tmpfs and am using rootfs but I want that rootfs
> to be ramfs, not tmpfs" code doesn't seem to be a real-world concern, does
> it?)

I must be missing something.  Which systems don't specify "root=" on
the boot command line.  If we want to include and restore xattrs,
there needs to be a way of using tmpfs.

Mimi

> 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  2 ++
> >  init/do_mounts.c                                | 15 +++++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> I suppose I should do a documentation update too. Lemme send a proper one
> after work...
> 
> Rob
> 
> P.S. While I'm at it, I've meant to wire up rootflags= so you can specify
> a memory limit other than 50% forever, I should do that too. And resend
> my "make DEVTMPFS_MOUNT apply to initramfs" patch (with the debian bug
> workaround)...
> 
