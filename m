Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932358AbeDWSiy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:38:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46638 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeDWSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:38:52 -0400
X-Google-Smtp-Source: AIpwx4+davGhKjRl3wMJwstFZxwWItYFB5FTMHAV5HxlVr8ByBm5OlFdMCHSSMjrRoXHY0eWXxA1ow==
Date: Mon, 23 Apr 2018 12:38:48 -0600
From: Anatoliy Glagolev <glagolig@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, fujita.tomonori@lab.ntt.co.jp,
        martin.petersen@oracle.com, jthumshirn@suse.de, hare@suse.com,
        bblock@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bsg referencing bus driver module
Message-ID: <20180423183845.GA21609@xldev-tmpl.dev.purestorage.com>
References: <CANFzKepsGq0EHX4GPtC0RZOWqVf2fTJ6uA2WH-SZNsBuwMJ5KA@mail.gmail.com>
 <CANFzKer6QDaJALX3LKPF2DV6LgczTh-efQe9+zeK8BuxTWFt1A@mail.gmail.com>
 <CANFzKepRSA+VoVAvOfW6U_qHFVDZex+=hQ=QhU+7Z=unvwejJQ@mail.gmail.com>
 <1524218126.3321.6.camel@HansenPartnership.com>
 <20180420224404.GC32372@xldev-tmpl.dev.purestorage.com>
 <1524383279.3389.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524383279.3389.7.camel@HansenPartnership.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, James. The idea of cutting communications with Scsi_Host at
bsg_unregister_queue(..) time and leaving bsg_class_device to
its own fate makes a lot of sense, conceptually. But there are
implementation issues that are difficult to work around.

bsg.c creates bsg_class_device and takes a reference to Scsi_Host
at bsg_register_queue(..) time. The reference is dropped at
bsg_class_device's release(..) function. If the driver implementing
Scsi_Host template is not around we crash.
We could move the reference drop from bsg_class_device's release(..)
function to bsg_unregister_queue(..). That would be a small change in
bsg.c. But bsg.c sets Scsi_Host as the parent of bsg_class_device's
device. We cannot have a device around with a dangling parent.
A device's parent cannot be changed dynamically. Not setting
the device's parent at creation may affect software relying
on bsg_class_device - Scsi_Host child-parent relations.

It looks like I am out of options. Do you have suggestions on
how to work around Scsi_Host being bsg_class_device's parent?
