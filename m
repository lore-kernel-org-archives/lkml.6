Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D74BC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013AF20644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 04:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ypahs66F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013AF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJVNOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 09:14:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62084 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeJVNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 09:14:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0D4511FF69;
        Mon, 22 Oct 2018 00:57:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=sasl; bh=uV24y6O8Gy0s
        IxAKccmBq6lQ838=; b=Ypahs66Fl30c9UMvUlwhFiSEqefAAHk7Bz+95O6I1nKc
        oZyTu/Vj3e7s00fhtu7pio9ECe2pbRJn/9y/GTy5HgyNJxBi4YLEwYP+TvUrg642
        XCMzEueC2WDYIe5wAd+bdt6QHav0YKAl/0tDPwfCtG2JvVg90Q1br+UIcbO+5b4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=subject:to:cc
        :references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MAD+vg
        7uZKxuiwpO9JChbutfSYX4KoRb6GAtkmhfYD8i1plzOVi52JxJ6KwLvWQhYqiAgT
        dXiUyDC/Sh48fqLVEPRYCVT/3UqPe8CMB0y8IBoPDlFZU7dYViSWWOEdy4d44KDI
        ikCLKZVVHFkvwEQkcScuISTTKMuH77ie9UOmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C912311FF68;
        Mon, 22 Oct 2018 00:57:12 -0400 (EDT)
Received: from [192.168.1.128] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 138A011FF67;
        Mon, 22 Oct 2018 00:57:12 -0400 (EDT)
Subject: Re: [PATCH] jffs2: Fix use of uninitialized delayed_work, lockdep
 breakage
To:     Hou Tao <houtao1@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org
References: <20181019083020.14335-1-daniel.santos@pobox.com>
 <d2f16a3a-7237-6c4e-5ff8-43f05bdb7e0f@huawei.com>
From:   Daniel Santos <daniel.santos@pobox.com>
Message-ID: <1868afe1-734f-7b44-535a-ac722b6722a4@pobox.com>
Date:   Sun, 21 Oct 2018 23:56:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d2f16a3a-7237-6c4e-5ff8-43f05bdb7e0f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: F01619FA-D5B6-11E8-9F9D-063AD72159A7-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2018 07:32 PM, Hou Tao wrote:
>
> On 2018/10/19 16:30, Daniel Santos wrote:
>> jffs2_sync_fs makes the assumption that if CONFIG_JFFS2_FS_WRITEBUFFER
>> is defined then a write buffer is available and has been initialized.
>> However, this does is not the case when the mtd device has no
>> out-of-band buffer:
>>
>> int jffs2_nand_flash_setup(struct jffs2_sb_info *c)
>> {
>>         if (!c->mtd->oobsize)
>>                 return 0;
>> ...
>>
>> The resulting call to cancel_delayed_work_sync passing a uninitialized
>> (but zeroed) delayed_work struct forces lockdep to become disabled.
>>
>> [   90.050639] overlayfs: upper fs does not support tmpfile.
>> [   90.652264] INFO: trying to register non-static key.
>> [   90.662171] the code is fine but needs lockdep annotation.
>> [   90.673090] turning off the locking correctness validator.
>> [   90.684021] CPU: 0 PID: 1762 Comm: mount_root Not tainted 4.14.63 #=
0
>> [   90.696672] Stack : 00000000 00000000 80d8f6a2 00000038 805f0000 80=
444600 8fe364f4 805dfbe7
>> [   90.713349]         80563a30 000006e2 8068370c 00000001 00000000 00=
000001 8e2fdc48 ffffffff
>> [   90.730020]         00000000 00000000 80d90000 00000000 00000106 00=
000000 6465746e 312e3420
>> [   90.746690]         6b636f6c 03bf0000 f8000000 20676e69 00000000 80=
000000 00000000 8e2c2a90
>> [   90.763362]         80d90000 00000001 00000000 8e2c2a90 00000003 80=
260dc0 08052098 80680000
>> [   90.780033]         ...
>> [   90.784902] Call Trace:
>> [   90.789793] [<8000f0d8>] show_stack+0xb8/0x148
>> [   90.798659] [<8005a000>] register_lock_class+0x270/0x55c
>> [   90.809247] [<8005cb64>] __lock_acquire+0x13c/0xf7c
>> [   90.818964] [<8005e314>] lock_acquire+0x194/0x1dc
>> [   90.828345] [<8003f27c>] flush_work+0x200/0x24c
>> [   90.837374] [<80041dfc>] __cancel_work_timer+0x158/0x210
>> [   90.847958] [<801a8770>] jffs2_sync_fs+0x20/0x54
>> [   90.857173] [<80125cf4>] iterate_supers+0xf4/0x120
>> [   90.866729] [<80158fc4>] sys_sync+0x44/0x9c
>> [   90.875067] [<80014424>] syscall_common+0x34/0x58
>>
>> Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
>> ---
>>  fs/jffs2/super.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
>> index 793ad30970ff..cae4ecda3c50 100644
>> --- a/fs/jffs2/super.c
>> +++ b/fs/jffs2/super.c
>> @@ -101,7 +101,8 @@ static int jffs2_sync_fs(struct super_block *sb, i=
nt wait)
>>  	struct jffs2_sb_info *c =3D JFFS2_SB_INFO(sb);
>> =20
>>  #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
>> -	cancel_delayed_work_sync(&c->wbuf_dwork);
>> +	if (jffs2_is_writebuffered(c))
>> +		cancel_delayed_work_sync(&c->wbuf_dwork);
>>  #endif
>> =20
>>  	mutex_lock(&c->alloc_sem);
>>
> Reviewed-by: Hou Tao <houtao1@huawei.com>
>
> And I am curious that why is there NAND Flash without OOB area ? So for=
 them
> the ECC data must be saved in data area ?
>
> Regards,
>
> Tao

Thank you.

I'm not intimately familiar with these, but it's an SPI NOR chip and I'm
pretty sure they that they don't have ECC.=C2=A0 Specifically a Winbond
w25q128fv using drivers/mtd/devices/m25p80.c.

Thanks,
Daniel



