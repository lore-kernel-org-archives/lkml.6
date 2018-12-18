Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE2F2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeLRReD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:34:03 -0500
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:59432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbeLRReC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:34:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2527118028995;
        Tue, 18 Dec 2018 17:34:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blow87_400871a9d6404
X-Filterd-Recvd-Size: 4506
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Dec 2018 17:33:59 +0000 (UTC)
Message-ID: <4db484684a6e9b096c7fdf57673fd208d1c4005a.camel@perches.com>
Subject: Re: [PATCH] cifs: check kzalloc return
From:   Joe Perches <joe@perches.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 09:33:58 -0800
In-Reply-To: <1545150439-26055-1-git-send-email-hofrat@osadl.org>
References: <1545150439-26055-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 17:27 +0100, Nicholas Mc Guire wrote:
> kzalloc can return NULL so a check is needed. While there is a
> check for ret_buf there is no check for the allocation of
> ret_buf->crfid.fid - this check is thus added. Both call-sites
> of tconInfoAlloc() check for NULL return of tconInfoAlloc()
> so returning NULL on failure of kzalloc() here seems appropriate.
> As the kzalloc() is the only thing here that can fail it is
> moved to the beginning so as not to initialize other resources
> on failure of kzalloc.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 3d4ef9a15343 ("smb3: fix redundant opens on root")
> ---
> 
> Problem located with an experimental coccinelle script
> 
> While at it make checkpatch happy by using *ret_buf->crfid.fid
> rather than struct cifs_fid.
> 
> Patch was compile tested with: x86_64_defconfig + CIFS=m
> (with some unrelated smatch warnings and some pending cocci fixes)
> 
> Patch is against v4.20-rc7 (localversion-next is next-20181218)
[]
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
[]
> @@ -113,6 +113,13 @@ tconInfoAlloc(void)
>  	struct cifs_tcon *ret_buf;
>  	ret_buf = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
>  	if (ret_buf) {
> +		ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid),
> +					     GFP_KERNEL);
> +		if (!ret_buf->crfid.fid) {
> +			kfree(ret_buf);
> +			return NULL;
> +		}
> +
>  		atomic_inc(&tconInfoAllocCount);
>  		ret_buf->tidStatus = CifsNew;
>  		++ret_buf->tc_count;
> @@ -120,8 +127,6 @@ tconInfoAlloc(void)
>  		INIT_LIST_HEAD(&ret_buf->tcon_list);
>  		spin_lock_init(&ret_buf->open_file_lock);
>  		mutex_init(&ret_buf->crfid.fid_mutex);
> -		ret_buf->crfid.fid = kzalloc(sizeof(struct cifs_fid),
> -					     GFP_KERNEL);
>  		spin_lock_init(&ret_buf->stat_lock);
>  		atomic_set(&ret_buf->num_local_opens, 0);
>  		atomic_set(&ret_buf->num_remote_opens, 0);

Perhaps use a more common style by returning early on the
first possible failure too so the block can be unindented.

Maybe as a separate cleanup patch.
---
 fs/cifs/misc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 113980dba4d8..bee203055b30 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -111,21 +111,27 @@ struct cifs_tcon *
 tconInfoAlloc(void)
 {
 	struct cifs_tcon *ret_buf;
-	ret_buf = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
-	if (ret_buf) {
-		atomic_inc(&tconInfoAllocCount);
-		ret_buf->tidStatus = CifsNew;
-		++ret_buf->tc_count;
-		INIT_LIST_HEAD(&ret_buf->openFileList);
-		INIT_LIST_HEAD(&ret_buf->tcon_list);
-		spin_lock_init(&ret_buf->open_file_lock);
-		mutex_init(&ret_buf->crfid.fid_mutex);
-		ret_buf->crfid.fid = kzalloc(sizeof(struct cifs_fid),
-					     GFP_KERNEL);
-		spin_lock_init(&ret_buf->stat_lock);
-		atomic_set(&ret_buf->num_local_opens, 0);
-		atomic_set(&ret_buf->num_remote_opens, 0);
+
+	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
+	if (!ret_buf)
+		return NULL;
+	ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid), GFP_KERNEL);
+	if (!ret_buf->crfid.fid) {
+		kfree(ret_buf);
+		return NULL;
 	}
+
+	atomic_inc(&tconInfoAllocCount);
+	ret_buf->tidStatus = CifsNew;
+	++ret_buf->tc_count;
+	INIT_LIST_HEAD(&ret_buf->openFileList);
+	INIT_LIST_HEAD(&ret_buf->tcon_list);
+	spin_lock_init(&ret_buf->open_file_lock);
+	mutex_init(&ret_buf->crfid.fid_mutex);
+	spin_lock_init(&ret_buf->stat_lock);
+	atomic_set(&ret_buf->num_local_opens, 0);
+	atomic_set(&ret_buf->num_remote_opens, 0);
+
 	return ret_buf;
 }
 

