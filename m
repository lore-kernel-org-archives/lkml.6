Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeA3LXJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:23:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:44961 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeA3LXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:23:06 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: chenchacha <chen.chenchacha@foxmail.com>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>, pali.rohar@gmail.com
Subject: Re: [PATCH 3/3] fs: fat: add ioctl method in fat filesystem driver
References: <20180117104355.889-1-chen.chenchacha@foxmail.com>
        <20180117104355.889-4-chen.chenchacha@foxmail.com>
        <87r2q8n7gs.fsf@mail.parknet.co.jp>
        <0464dacb-b8f1-4bb2-3e05-e5f35ebf6e8e@foxmail.com>
Date: Tue, 30 Jan 2018 20:23:03 +0900
In-Reply-To: <0464dacb-b8f1-4bb2-3e05-e5f35ebf6e8e@foxmail.com>+BB9432B15A982F74
        (chenchacha's message of "Tue, 30 Jan 2018 09:52:20 +0800")
Message-ID: <87bmhbmvzc.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

chenchacha <chen.chenchacha@foxmail.com> writes:

> On 01/29/2018 09:02 PM, OGAWA Hirofumi wrote:
>> ChenGuanqiao <chen.chenchacha@foxmail.com> writes:
>>
>>> +static int fat_check_d_characters(char *label, unsigned long len)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < len; ++i) {
>>> +		switch (label[i]) {
>>> +		case 'a' ... 'z':
>>> +			label[i] = __toupper(label[i]);
>>> +		case 'A' ... 'Z':
>>> +		case '0' ... '9':
>>> +		case '_':
>>> +		case 0x20:
>>> +			continue;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>> Same question with previous though, what windows do if label = "a b c"?
>> (this is including space other than end of name or extension.)
> In win7, the volume label will be capitalized, and leaving spaces.
> Or, you mean I need to fill the rest of the space with "0x20"?

I see. However, what win7 stored, BTW? It was "A B C      ", or anything
other?

>>> +static int fat_ioctl_set_volume_label(struct file *file,
>>> +				      u8 __user *vol_label)
>>> +{
>>> +	int err = 0;
>>> +	u8 label[MSDOS_NAME];
>>> +	struct timespec ts;
>>> +	struct buffer_head *boot_bh;
>>> +	struct buffer_head *vol_bh;
>>> +	struct msdos_dir_entry *de;
>>> +	struct fat_boot_sector *b;
>>> +	struct inode *inode = file_inode(file);
>>> +	struct super_block *sb = inode->i_sb;
>>> +	struct msdos_sb_info *sbi = MSDOS_SB(sb);
>>> +
>> [...]
> I need remove "struct msdos_sb_info *sbi"?

If you didn't use sbi anymore, you should remove.

>>> +	err = mnt_want_write_file(file);
>>> +	if (err)
>>> +		goto out;
>>> +
>>> +	down_write(&sb->s_umount);
>> Looks like inode_lock() for rootdir is gone. It is necessary to
>> traverse+modify.
> Is it wrong for me to use the inode_lock() in patch v7? I need to lock 
> inode here, and turn off immediately after

inode_lock() is necessary to protect race with other dir operations.

I asked at v7, locking order to prevent the AB locking order bug.

I.e.
	mnt_want_write_file => down_write => inode_lock()
vs
	down_write => mnt_want_write_file => inode_lock()

Which is right one?

> mark_buffer_dirty(vol_bh)?

What is this asking?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
