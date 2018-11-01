Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE4C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA752081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2ilfaQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA752081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeKBINh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:13:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:41841 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeKBINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:13:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id t13-v6so54067ybb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9SPLquZYIA1PR5GbZs1M33G5+BrUBCq60TyqQhJWhKE=;
        b=G2ilfaQJ6zn2a251hU6IE//KdWy4P4v4spKZdftnCby6Yp7Jd5Aeiryrv3P3RxV4FC
         Ao/OqDLsGAoLDtJaPBbpZVIWZHsGzZU+ip+jRCNUdSAg0m3xAXvEI3rBS+dXEtEZJEMv
         dhEoMdjZGCjtFb9BsLHhqxhbrGaFBGsWCZdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9SPLquZYIA1PR5GbZs1M33G5+BrUBCq60TyqQhJWhKE=;
        b=FsOA1qsAontemBDIPGV3u8x97ov27Whv/3McIiQuuQ7eX1eEG8wiYc/eKz3wo1h4z7
         m7NjXZuDbvPGKtzrIxVrEPgQuiu1kWdoMTCDXlRkzz3NgP23JqPRKdeQ38MrF2tPVcI9
         MJ0W7exbyKLwvNolj8i2H3lZaSRIZAHjCK8zkFmxEW+PdC1DjdnEZuL0ZThSlysNNcop
         rCSUPHvQGGAefyr7wxAqK5bCZKcAuZzzMjJRvEYQOyF5BwZW/Gei4Vmyu1Y/SMWyx9w5
         CPsjIkOTfGMH5tmSTXj1g8qRHu/13g4HYGlGnJcCWL94jVQT/qgnKG6IwEdgu40iZH9n
         DswQ==
X-Gm-Message-State: AGRZ1gILEUxctoFkL7j1l49r4TBXGKDC6XDaMQmM/jkGLRp1aUeAhb0z
        kTn+asCaYlRERi35tj0Uj3MkgEes4Pk=
X-Google-Smtp-Source: AJdET5eomySiviUL+q/EFvfWpYuXimKEYG0+lN6efHCs4PhCS6cKRpXt5xfWJnmuL3VrC1zmBGD8Og==
X-Received: by 2002:a25:dbcd:: with SMTP id g196-v6mr9951042ybf.391.1541113715515;
        Thu, 01 Nov 2018 16:08:35 -0700 (PDT)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id g21-v6sm13260778ywk.5.2018.11.01.16.08.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 16:08:35 -0700 (PDT)
Received: by mail-yw1-f46.google.com with SMTP id j202-v6so43884ywa.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 16:08:35 -0700 (PDT)
X-Received: by 2002:a81:2953:: with SMTP id p80-v6mr9637804ywp.407.1541113224617;
 Thu, 01 Nov 2018 16:00:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Thu, 1 Nov 2018 16:00:23 -0700 (PDT)
In-Reply-To: <20181101171938-mutt-send-email-mst@kernel.org>
References: <20181101171938-mutt-send-email-mst@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 1 Nov 2018 16:00:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
Message-ID: <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        KVM <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com,
        Joe Perches <joe@perches.com>, lenaic@lhuard.fr,
        liang.z.li@intel.com, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:19 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb=
7d:
>
>   Linux 4.19 (2018-10-22 07:37:37 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_li=
nus
>
> for you to fetch changes up to 79f800b2e76923cd8ce0aa659cb5c019d9643bc9:
>
>   MAINTAINERS: remove reference to bogus vsock file (2018-10-24 21:16:14 =
-0400)
>
> ----------------------------------------------------------------
> virtio, vhost: fixes, tweaks
>
> virtio balloon page hinting support
> vhost scsi control queue
>
> misc fixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Bijan Mottahedeh (3):
>       vhost/scsi: Respond to control queue operations

+static void
+vhost_scsi_send_tmf_resp(struct vhost_scsi *vs,
+                          struct vhost_virtqueue *vq,
+                          int head, unsigned int out)
+{
+       struct virtio_scsi_ctrl_tmf_resp __user *resp;
+       struct virtio_scsi_ctrl_tmf_resp rsp;
+       int ret;
+
+       pr_debug("%s\n", __func__);
+       memset(&rsp, 0, sizeof(rsp));
+       rsp.response =3D VIRTIO_SCSI_S_FUNCTION_REJECTED;
+       resp =3D vq->iov[out].iov_base;
+       ret =3D __copy_to_user(resp, &rsp, sizeof(rsp));

Is it actually safe to trust that iov_base has passed an earlier
access_ok() check here? Why not just use copy_to_user() instead?

-Kees

>       vhost/scsi: Extract common handling code from control queue handler
>       vhost/scsi: Use common handling code in request queue handler
>
> Greg Edwards (1):
>       vhost/scsi: truncate T10 PI iov_iter to prot_bytes
>
> L=C3=A9na=C3=AFc Huard (1):
>       kvm_config: add CONFIG_VIRTIO_MENU
>
> Stefan Hajnoczi (1):
>       MAINTAINERS: remove reference to bogus vsock file
>
> Wei Wang (3):
>       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>       mm/page_poison: expose page_poisoning_enabled to kernel modules
>       virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
>
>  MAINTAINERS                         |   1 -
>  drivers/vhost/scsi.c                | 426 ++++++++++++++++++++++++++++--=
------
>  drivers/virtio/virtio_balloon.c     | 380 +++++++++++++++++++++++++++++-=
--
>  include/uapi/linux/virtio_balloon.h |   8 +
>  kernel/configs/kvm_guest.config     |   1 +
>  mm/page_poison.c                    |   6 +
>  6 files changed, 688 insertions(+), 134 deletions(-)



--=20
Kees Cook
