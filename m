Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82282C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530FA2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864550;
	bh=ajNBNeVh0Z4X8FJBb+DGBIkp/kVJjOJXkYK2wcJwZJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HhWkcv1+ZJ6Fm1HhKMzds51h1u+UPf0p3KS25q4hl0/vcRVj2bx1hjhpP+zqMebMd
	 JEJY6UBRQUxJOw7qhA3XztvYhlphTfDcv2jzbluIfZf2fGeaVeTSNjmztSfSthtFrr
	 2ticwKc4HJvBGRdkHxrkWSbs7C6/pU7jZEUe4YXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfAGMft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727612AbfAGMfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:35:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C92B206BB;
        Mon,  7 Jan 2019 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864543;
        bh=ajNBNeVh0Z4X8FJBb+DGBIkp/kVJjOJXkYK2wcJwZJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEvg62ybBIPlqUnGRucd2A3JYAscLwq886SNjlUHkOT2mEXlG0eWFpxd9kQoWxE3h
         zb6ymbMOzioVUCUSg7jFTZWu9WlXkYqsGQBopU+qwkGAJJfmVnw9CHWym2LFaul92x
         DAMpUbIlle0K3Um3LXk+hM8t50FeATKbaifa0tcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.20 045/145] media: dvb-usb-v2: Fix incorrect use of transfer_flags URB_FREE_BUFFER
Date:   Mon,  7 Jan 2019 13:31:22 +0100
Message-Id: <20190107104443.332815469@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 255095fa7f62ff09b6f61393414535c59c6b4cb0 upstream.

commit 1a0c10ed7bb1 ("media: dvb-usb-v2: stop using coherent memory for
URBs") incorrectly adds URB_FREE_BUFFER after every urb transfer.

It cannot use this flag because it reconfigures the URBs accordingly
to suit connected devices. In doing a call to usb_free_urb is made and
invertedly frees the buffers.

The stream buffer should remain constant while driver is up.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
CC: stable@vger.kernel.org # v4.18+
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb-v2/usb_urb.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/usb_urb.c
+++ b/drivers/media/usb/dvb-usb-v2/usb_urb.c
@@ -155,7 +155,6 @@ static int usb_urb_alloc_bulk_urbs(struc
 				stream->props.u.bulk.buffersize,
 				usb_urb_complete, stream);
 
-		stream->urb_list[i]->transfer_flags = URB_FREE_BUFFER;
 		stream->urbs_initialized++;
 	}
 	return 0;
@@ -186,7 +185,7 @@ static int usb_urb_alloc_isoc_urbs(struc
 		urb->complete = usb_urb_complete;
 		urb->pipe = usb_rcvisocpipe(stream->udev,
 				stream->props.endpoint);
-		urb->transfer_flags = URB_ISO_ASAP | URB_FREE_BUFFER;
+		urb->transfer_flags = URB_ISO_ASAP;
 		urb->interval = stream->props.u.isoc.interval;
 		urb->number_of_packets = stream->props.u.isoc.framesperurb;
 		urb->transfer_buffer_length = stream->props.u.isoc.framesize *
@@ -210,7 +209,7 @@ static int usb_free_stream_buffers(struc
 	if (stream->state & USB_STATE_URB_BUF) {
 		while (stream->buf_num) {
 			stream->buf_num--;
-			stream->buf_list[stream->buf_num] = NULL;
+			kfree(stream->buf_list[stream->buf_num]);
 		}
 	}
 


