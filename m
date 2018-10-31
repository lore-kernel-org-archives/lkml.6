Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F26DECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378C420847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XKi3AvcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378C420847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeKAI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:26:48 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34726 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbeKAI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:26:47 -0400
Received: from emerald.amanokami.net (unknown [96.44.9.81])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0AAE811F2;
        Thu,  1 Nov 2018 00:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1541028388;
        bh=EZGOw/j7tr+oKO3jtwt4JL3i+Fs1aU4VF5qrCN8OpPU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=XKi3AvcFYXle9xrJtQ8ynOLS7JbKvTzhrxHsFw4DeajesOU8FGHiFnva4x9Cv1ZoS
         CTG7rSxd0V8Mijiaxm4AY8LwC7gmNDaiC7kwEKOGaU/Yh/8lUvIz3PHx07gqMk6VrI
         ReYrFsRdAuI1xuz7pQLIS5C+2Zh4wrwf2y4zSu5o=
Date:   Wed, 31 Oct 2018 19:26:20 -0400
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Bin Liu <b-liu@ti.com>, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu, rogerq@ti.com
Subject: Re: [PATCH 5/6] usb: musb: gadget: implement send_response
Message-ID: <20181031232620.GA13896@emerald.amanokami.net>
References: <20181010024903.1633-1-paul.elder@ideasonboard.com>
 <20181010024903.1633-6-paul.elder@ideasonboard.com>
 <20181011160746.GA8763@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011160746.GA8763@uda0271908>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

On Thu, Oct 11, 2018 at 11:07:46AM -0500, Bin Liu wrote:
> Hi,
> 
> On Tue, Oct 09, 2018 at 10:49:02PM -0400, Paul Elder wrote:
> > This patch implements a mechanism to signal the MUSB driver to reply to
> > a control OUT request with STALL or ACK.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> The patch looks good to me, here is my Acked-by:
> 
> Acked-by: Bin Liu <b-liu@ti.com>
> 
> but I am unable to test this patch set - the current Greg's usb-next
> tree gives deadlock error between composite_disconnect() and
> usb_function_deactivate() when loading g_webcam.ko on BeagleboneBlack.
> The error happens before applying this patch set.

We don't use g_webcam anymore, because it doesn't offer the flexibility
that configfs does (for example, only one function can be configured with
g_webcam). There are no features that g_webcam offers that configfs doesn't.

I was unable to reproduce the deadlock that you mention on Greg's
usb-next tree. Which commit were you on?
I did, however, get the deadlock that you mention upon *killing* the
userspace application providing the stream, not when loading g_webcam.ko.

Here is a sample script for setting up a UVC gadget through configfs
(I haven't tested this exact script; I extracted the functional
components):

CONFIGFS="/sys/kernel/config"
GADGET="$CONFIGFS/usb_gadget"
VID="0x0525"
PID="0xa4a2"
SERIAL="0123456789"
MANUF=$(hostname)
PRODUCT="UVC Gadget"
UDC=`ls /sys/class/udc`

cd $GADGET/g1
echo $VID > idVendor
echo $PID > idProduct

mkdir -p strings/0x409
echo $SERIAL > strings/0x409/serialnumber
echo $MANUF > strings/0x409/manufacturer
echo $PRODUCT > strings/0x409/product

mkdir configs/c.1
mkdir configs/c.1/strings/0x409

# create uvc
CONFIG="configs/c.1"
FUNCTION="uvc.0"

mkdir functions/$FUNCTION

# create frame 640x360 uncompressed
WIDTH=640
HEIGHT=360

wdir=functions/$FUNCTION/streaming/uncompressed/u/${HEIGHT}p

mkdir $wdir
echo $WIDTH > $wdir/wWidth
echo $HEIGHT > $wdir/wHeight
echo $(( $WIDTH * $HEIGHT * 2 )) > $wdir/dwMaxVideoFrameBufferSize
cat <<EOF > $wdir/dwFrameInterval
666666
100000
5000000
EOF
# end create frame

mkdir functions/$FUNCTION/streaming/header/h
cd functions/$FUNCTION/streaming/header/h
ln -s ../../uncompressed/u
cd ../../class/fs
ln -s ../../header/h
cd ../../class/hs
ln -s ../../header/h
cd ../../../control
mkdir header/h
ln -s header/h class/fs
ln -s header/h class/ss
cd ../../../

# Set the packet size: uvc gadget max size is 3k...
echo 3072 > functions/$FUNCTION/streaming_maxpacket
echo 2048 > functions/$FUNCTION/streaming_maxpacket
echo 1024 > functions/$FUNCTION/streaming_maxpacket

ln -s functions/$FUNCTION configs/c.1
# end create uvc

echo $UDC > UDC


Thanks,

Paul
