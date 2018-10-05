Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0061EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D894206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RhdUuVFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D894206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeJEVkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 17:40:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38054 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbeJEVkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 17:40:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id c1-v6so11857274ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Q+ZFwsRQJmnJZPIyqJs32iI+vIHdCsgJCC9YYOqrls=;
        b=RhdUuVFKVQn+Z6znNDflHxRjFjoaAt7H4hkIe9bKRT+mt+KrUwVWJtiAO8chS7BJOL
         traUK4nmyTzCk0V9fQLLebYvi9Jz0L06go7UhVNpK29POgOFCfOXPKaVnpa2eBqtTX9Z
         kxdE5J0KFZm1Idyuo9W+ssnw3dvKpURjJi5O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5Q+ZFwsRQJmnJZPIyqJs32iI+vIHdCsgJCC9YYOqrls=;
        b=BXATOa87ggRVT/MNSHxMkHPIQsaOpJbc+lMJb11UssLLrzZCSEjlmQOsPT+90/vuM+
         mC3wDaQtp9LkrNIaEatxxCgZIJfigIuUWBfsnhjgiL0vIDKx9bJbuFDSfura+ZDhrXm+
         Zw189z0FcCmT04oqq0xXqpNZRjcv7XcNhP1bwzqbp67CvJOqhJ+Y9LWDanJphKhSkukX
         Fij+cUgVjmeG1MEel44CJHJiNhYXlyepJ/FXIh8K/K+zeuI2KW7RBa/S9Jjclo6zl4k7
         FgnZ97Pxicd8AU7SS2PP7zFivcFwvR4FtooFQItwikuBXwOTJevqV4qK0h1FUvMEIT48
         7cgw==
X-Gm-Message-State: ABuFfojCLY5ZSRoHMaBfcK5Pqa+xIZnHiIZbEiG6cMu7nvD6Uw+H+cFT
        IXMIgFU8I78zfNYrCtpLDjgnyw==
X-Google-Smtp-Source: ACcGV60m9sc+Z/XUbC+VXXL4HaLTEggK/k6RFcYryYe05RtbhgChxVM1YCPfsnBZCxA323Q8K223hg==
X-Received: by 2002:aa7:c5c5:: with SMTP id h5-v6mr14268415eds.27.1538750489947;
        Fri, 05 Oct 2018 07:41:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 18-v6sm251862edt.34.2018.10.05.07.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 07:41:29 -0700 (PDT)
Date:   Fri, 5 Oct 2018 16:41:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christophe de Dinechin <cdupontd@redhat.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, virtio-dev@redhat.com,
        dri-devel@lists.freedesktop.org,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
Message-ID: <20181005144127.GE31561@phenom.ffwll.local>
Mail-Followup-To: Christophe de Dinechin <cdupontd@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>, virtio-dev@redhat.com,
        dri-devel@lists.freedesktop.org,
        "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <20181005125154.19824-1-kraxel@redhat.com>
 <1BA83F18-87E5-4B01-A2D9-01777078B637@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1BA83F18-87E5-4B01-A2D9-01777078B637@redhat.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:38:11PM +0200, Christophe de Dinechin wrote:
> 
> 
> > On 5 Oct 2018, at 14:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > 
> > The feature allows the guest request an EDID blob (describing monitor
> > capabilities) for a given scanout (aka virtual monitor connector).
> > 
> > It brings a new command message, which has just a scanout field (beside
> > the standard virtio-gpu header) and a response message which carries the
> > EDID data.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> > include/uapi/linux/virtio_gpu.h | 17 +++++++++++++++++
> > 1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
> > index f43c3c6171..1cef1ff339 100644
> > --- a/include/uapi/linux/virtio_gpu.h
> > +++ b/include/uapi/linux/virtio_gpu.h
> > @@ -41,6 +41,7 @@
> > #include <linux/types.h>
> > 
> > #define VIRTIO_GPU_F_VIRGL 0
> > +#define VIRTIO_GPU_F_EDID  1
> > 
> > enum virtio_gpu_ctrl_type {
> > 	VIRTIO_GPU_UNDEFINED = 0,
> > @@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
> > 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
> > 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
> > 	VIRTIO_GPU_CMD_GET_CAPSET,
> > +	VIRTIO_GPU_CMD_GET_EDID,
> > 
> > 	/* 3d commands */
> > 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
> > @@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
> > 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
> > 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
> > 	VIRTIO_GPU_RESP_OK_CAPSET,
> > +	VIRTIO_GPU_RESP_OK_EDID,
> > 
> > 	/* error responses */
> > 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
> > @@ -291,6 +294,20 @@ struct virtio_gpu_resp_capset {
> > 	__u8 capset_data[];
> > };
> > 
> > +/* VIRTIO_GPU_CMD_GET_EDID */
> > +struct virtio_gpu_get_edid {
> > +	struct virtio_gpu_ctrl_hdr hdr;
> > +	__le32 scanout;
> > +};
> > +
> > +/* VIRTIO_GPU_RESP_OK_EDID */
> > +struct virtio_gpu_resp_edid {
> > +	struct virtio_gpu_ctrl_hdr hdr;
> > +	__le32 scanout;
> > +	__le32 size;
> > +	__u8 edid[1024];
> 
> Wouldn’t it be enough to stick to EDID 2.0 (256 bytes)?
> 
> If not, maybe add comment to explain why you chose 1024.

EDID in the wild can be up to 512 bytes.
-Daniel

> 
> > +};
> > +
> > #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
> > 
> > struct virtio_gpu_config {
> > -- 
> > 2.9.3
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
