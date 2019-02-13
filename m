Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A0DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAF920838
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393046AbfBMR3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:29:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:53258 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388566AbfBMR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:29:45 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 642231B408E;
        Thu, 14 Feb 2019 02:29:44 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x1DHThhl020052
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 02:29:44 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x1DHTggU013110
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 02:29:42 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x1DHTgiP013109;
        Thu, 14 Feb 2019 02:29:42 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Timothy Redaelli <tredaelli@redhat.com>
Subject: Re: [PATCH v3] vfat: don't read garbage after last dirent
References: <20190201001408.7453-1-mcroce@redhat.com>
Date:   Thu, 14 Feb 2019 02:29:42 +0900
In-Reply-To: <20190201001408.7453-1-mcroce@redhat.com> (Matteo Croce's message
        of "Fri, 1 Feb 2019 01:14:08 +0100")
Message-ID: <87sgwr61h5.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matteo Croce <mcroce@redhat.com> writes:

> The FAT32 File System Specification[1] states that:
>
>     If DIR_Name[0] == 0x00, then the directory entry is free, and there
>     are no allocated directory entries after this one.
>
>     The special 0 value, indicates to FAT file system driver code that
>     the rest of the entries in this directory do not need to be examined
>     because they are all free.
>
> This is not enforced by Linux, and is possible to read garbage if not
> all dirents after the last one are filled with zeroes.
>
> [1] http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/fatgen103.doc

Tested some, and this patch seems to be not working.  First
fat_readdir() exits by zero dir entry, but dir pos is updated to next
position, then second fat_readdir() continue with previous dir pos and
will read beyond zero dir entry.

So, maybe, we are better move down the zero dir entry handling into
fat_get_entry(), instead of copying several places. But like you know,
we would like to skip the zero dir entry only if read/search operation.

Maybe, adding flag to fat_get_entry() and use it, or adding small
wrapper? And in read/search case, we should not update *pos if hit the
zero dir entry.

I'm not testing the above actually though, we would need such.

Thanks.

> Reported-by: Timothy Redaelli <tredaelli@redhat.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  fs/fat/dir.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fs/fat/dir.c b/fs/fat/dir.c
> index 9d01db37183f..d919a1ee519c 100644
> --- a/fs/fat/dir.c
> +++ b/fs/fat/dir.c
> @@ -314,7 +314,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
>  
>  		if (ds->id & 0x40)
>  			(*unicode)[offset + 13] = 0;
> -		if (fat_get_entry(dir, pos, bh, de) < 0)
> +		if (fat_get_entry(dir, pos, bh, de) < 0 || !(*de)->name[0])
>  			return PARSE_EOF;
>  		if (slot == 0)
>  			break;
> @@ -476,7 +476,8 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
>  
>  	err = -ENOENT;
>  	while (1) {
> -		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +		if (fat_get_entry(inode, &cpos, &bh, &de) == -1 ||
> +		    !de->name[0])
>  			goto end_of_dir;
>  parse_record:
>  		nr_slots = 0;
> @@ -588,7 +589,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
>  
>  	bh = NULL;
>  get_new:
> -	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
> +	if (fat_get_entry(inode, &cpos, &bh, &de) == -1 || !de->name[0])
>  		goto end_of_dir;
>  parse_record:
>  	nr_slots = 0;
> @@ -898,7 +899,8 @@ int fat_get_dotdot_entry(struct inode *dir, struct buffer_head **bh,
>  	loff_t offset = 0;
>  
>  	*de = NULL;
> -	while (fat_get_short_entry(dir, &offset, bh, de) >= 0) {
> +	while (fat_get_short_entry(dir, &offset, bh, de) >= 0 &&
> +	       (*de)->name[0]) {
>  		if (!strncmp((*de)->name, MSDOS_DOTDOT, MSDOS_NAME))
>  			return 0;
>  	}
> @@ -916,7 +918,8 @@ int fat_dir_empty(struct inode *dir)
>  
>  	bh = NULL;
>  	cpos = 0;
> -	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
> +	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0 &&
> +	       de->name[0]) {
>  		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
>  		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
>  			result = -ENOTEMPTY;
> @@ -941,7 +944,8 @@ int fat_subdirs(struct inode *dir)
>  
>  	bh = NULL;
>  	cpos = 0;
> -	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0) {
> +	while (fat_get_short_entry(dir, &cpos, &bh, &de) >= 0 &&
> +	       de->name[0]) {
>  		if (de->attr & ATTR_DIR)
>  			count++;
>  	}
> @@ -961,7 +965,7 @@ int fat_scan(struct inode *dir, const unsigned char *name,
>  	sinfo->slot_off = 0;
>  	sinfo->bh = NULL;
>  	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
> -				   &sinfo->de) >= 0) {
> +				   &sinfo->de) >= 0 && sinfo->de->name[0]) {
>  		if (!strncmp(sinfo->de->name, name, MSDOS_NAME)) {
>  			sinfo->slot_off -= sizeof(*sinfo->de);
>  			sinfo->nr_slots = 1;
> @@ -985,7 +989,7 @@ int fat_scan_logstart(struct inode *dir, int i_logstart,
>  	sinfo->slot_off = 0;
>  	sinfo->bh = NULL;
>  	while (fat_get_short_entry(dir, &sinfo->slot_off, &sinfo->bh,
> -				   &sinfo->de) >= 0) {
> +				   &sinfo->de) >= 0 && sinfo->de->name[0]) {
>  		if (fat_get_start(MSDOS_SB(sb), sinfo->de) == i_logstart) {
>  			sinfo->slot_off -= sizeof(*sinfo->de);
>  			sinfo->nr_slots = 1;

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
