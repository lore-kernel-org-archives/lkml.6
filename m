Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeBLRUR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:20:17 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43242 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbeBLRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:20:14 -0500
X-Google-Smtp-Source: AH8x226dZUMT0vdleKMs+neLMDTaquVgovnMmjappo99dXk3vMXHwhqCJqGgMCxZRfWPEozqVkM6Zg==
Date: Mon, 12 Feb 2018 09:20:10 -0800
From: Tejun Heo <tj@kernel.org>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Mark Lord <mlord@pobox.com>, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] libata: fix length validation of ATAPI-relayed SCSI
 commands
Message-ID: <20180212172010.GB695913@devbig577.frc2.facebook.com>
References: <001a114aa95cfa4339055cd4e8e0@google.com>
 <20180204043056.16466-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204043056.16466-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 08:30:56PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> syzkaller reported a crash in ata_bmdma_fill_sg() when writing to
> /dev/sg1.  The immediate cause was that the ATA command's scatterlist
> was not DMA-mapped, which causes 'pi - 1' to underflow, resulting in a
> write to 'qc->ap->bmdma_prd[0xffffffff]'.
> 
> Strangely though, the flag ATA_QCFLAG_DMAMAP was set in qc->flags.  The
> root cause is that when __ata_scsi_queuecmd() is preparing to relay a
> SCSI command to an ATAPI device, it doesn't correctly validate the CDB
> length before copying it into the 16-byte buffer 'cdb' in 'struct
> ata_queued_cmd'.  Namely, it validates the fixed CDB length expected
> based on the SCSI opcode but not the actual CDB length, which can be
> larger due to the use of the SG_NEXT_CMD_LEN ioctl.  Since 'flags' is
> the next member in ata_queued_cmd, a buffer overflow corrupts it.
> 
> Fix it by requiring that the actual CDB length be <= 16 (ATAPI_CDB_LEN).

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
