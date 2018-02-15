Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032812AbeBONuT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:50:19 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33795 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031445AbeBONuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:50:18 -0500
X-Google-Smtp-Source: AH8x224+3X4WjxpYymx1/jp+KwbuPzr45ScpeOfvRSNzMXy/lrGABkSVk6Lsc29Y6aPcQGQLt5iSIuNWTR0aBjWqABQ=
MIME-Version: 1.0
From: Julien Durillon <julien@durillon.xyz>
Date: Thu, 15 Feb 2018 14:49:56 +0100
Message-ID: <CAPVZMnqi0dF1u=Q223trP=mtvYd80Ydp5wamtz3Vt3xhRY-FEQ@mail.gmail.com>
Subject: [BUG? NVME Linux-4.15] Dracut loops indefinitely with 4.15
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I opened an issue here:
https://github.com/dracutdevs/dracut/issues/373 for dracut. You can
read there how dracuts enters an infinite loop.

TL;DR: in linux-4.14, trying to find the last "slave" of /dev/dm-0
ends with a maj:min of "249:0" which does not exist in /sys/dev/block.
In linux-4.15, the same thing loops as "249:0" exists.

## My configuration

I'm using a nvme ssd disk named "nvme0n1". It has two partitions: an
EFI one and a luks encrypted btrfs volume. So in /dev I have /dev/dm-0
that is referenced to by /dev/mapper/root.
/dev/mapper/root -> /dev/dm-0 is the mapped un-encrypted
"/dev/nvme0n1p2" volume used as a btrfs volume.

## My problem

*Before* linux-4.15, `stat /dev/dm-0` displays:

  File: /dev/dm-0
  Size: 0               Blocks: 0          IO Block: 4096   block special file
Device: 6h/6d   Inode: 2768        Links: 1     Device type: fa,0
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/    disk)
Access: 2018-02-12 17:49:46.020513274 +0100
Modify: 2018-02-12 17:49:46.020513274 +0100
Change: 2018-02-12 17:49:46.020513274 +0100
Birth: -

So the device type is "fa,0", which is translated by dracut as "250:0".

*Starting at* linux-4.15, `stat /dev/dm-0` displays:

  File: /dev/dm-0
  Size: 0               Blocks: 0          IO Block: 4096   block special file
Device: 6h/6d   Inode: 17795       Links: 1     Device type: f9,0
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/    disk)
Access: 2018-02-15 14:38:56.570529189 +0100
Modify: 2018-02-15 14:38:56.570529189 +0100
Change: 2018-02-15 14:38:56.570529189 +0100
 Birth: -

So the device type is "f9,0", which is translated by dracut as "249:0".

I'm posting it here because I don't understand why the kernel changed
the device type. Is it intended?

Regards,
-- 
Julien Durillon
