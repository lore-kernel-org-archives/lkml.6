Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C67ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706F520658
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706F520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJQWcD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:32:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54666 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJQWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:32:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCmvb-0000oe-W0; Wed, 17 Oct 2018 08:36:04 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gCmvb-0002fB-0g; Wed, 17 Oct 2018 08:36:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
References: <19866.1539782101@warthog.procyon.org.uk>
        <68a2107f-bf70-055b-86cf-1ba2ba9422bf@gmail.com>
        <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
        <153754766004.17872.9829232103614083565.stgit@warthog.procyon.org.uk>
        <9b8bf436-65de-13b9-0002-0479d11c18ca@gmail.com>
        <20181013061141.GR32577@ZenIV.linux.org.uk>
        <28710.1539782412@warthog.procyon.org.uk>
        <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com>
Date:   Wed, 17 Oct 2018 09:35:45 -0500
In-Reply-To: <f6f2553e-f64d-9c26-4290-baf43e5f533b@gmail.com> (Alan Jenkins's
        message of "Wed, 17 Oct 2018 15:31:26 +0100")
Message-ID: <87woqgiqta.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1gCmvb-0002fB-0g;;;mid=<87woqgiqta.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hcb5RQKjAH6x0dAjbhxUx+4sBQrfVGB4=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 31/34] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #12]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Jenkins <alan.christopher.jenkins@gmail.com> writes:

> On 17/10/2018 14:20, David Howells wrote:
>> David Howells <dhowells@redhat.com> wrote:
>>
>>> I should probably check that the picked point is actually a mountpoint.
>> The root of the mount object at the path specified, that is, perhaps with
>> something like the attached.
>>
>> David
>
>
> I agree.  I'm happy to see this is using the same check as do_remount().
>
>
> * change filesystem flags. dir should be a physical root of filesystem.
> * If you've mounted a non-root directory somewhere and want to do remount
> * on it - tough luck.
> */

Davids check will work for bind mounts as well.  It just won't work it
just won't work for files or subdirectories of some mountpoint.

Eric

>> ---
>> diff --git a/fs/fsopen.c b/fs/fsopen.c
>> index f673e93ac456..aaaaa17a233c 100644
>> --- a/fs/fsopen.c
>> +++ b/fs/fsopen.c
>> @@ -186,6 +186,10 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
>>   	if (ret < 0)
>>   		goto err;
>>   +	ret = -EINVAL;
>> +	if (target.mnt->mnt_root != target.dentry)
>> +		goto err_path;
>> +
>>   	fc = vfs_new_fs_context(target.dentry->d_sb->s_type, target.dentry,
>>   				0, 0, FS_CONTEXT_FOR_RECONFIGURE);
>>   	if (IS_ERR(fc)) {
>>
