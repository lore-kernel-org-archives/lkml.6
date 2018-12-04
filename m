Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A6FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B25206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQXe9cNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B25206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLDNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDNll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:41:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F93206B6;
        Tue,  4 Dec 2018 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543930899;
        bh=0eQ9hru12+7U1UMnJDjSLAOpsPOlb8YZuMEVFOb2few=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQXe9cNwayV+UVY2sm2WVkUlkipjET9pYHQWDIXS2ml2O+gWt/6W9xtaYOAOyDYXP
         W9KnC5GIXCerPN1gdmPPeBck2P4muedGmnHPmwOVl3ISAvF0zvDAsb/hm//1nWwT8p
         lnjSxqTXoxwj5Pk3UxYwCWi2Gu1lF01rxulwDXJ8=
Date:   Tue, 4 Dec 2018 14:41:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sage Weil <sage@redhat.com>, ben.hutchings@codethink.co.uk,
        sashal@kernel.org
Subject: Re: [PATCH 4.14 018/146] libceph: implement CEPHX_V2 calculation mode
Message-ID: <20181204134137.GB4749@kroah.com>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103727.530335739@linuxfoundation.org>
 <CAOi1vP_uNBXySo4yNOjcSBUgqDRjo2abm41UZCXazUG7ygRVcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP_uNBXySo4yNOjcSBUgqDRjo2abm41UZCXazUG7ygRVcA@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:06:40PM +0100, Ilya Dryomov wrote:
> On Tue, Dec 4, 2018 at 12:01 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > commit cc255c76c70f7a87d97939621eae04b600d9f4a1 upstream.
> >
> > Derive the signature from the entire buffer (both AES cipher blocks)
> > instead of using just the first half of the first block, leaving out
> > data_crc entirely.
> >
> > This addresses CVE-2018-1129.
> >
> > Link: http://tracker.ceph.com/issues/24837
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > Reviewed-by: Sage Weil <sage@redhat.com>
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  include/linux/ceph/ceph_features.h |  7 +--
> >  net/ceph/auth_x.c                  | 73 +++++++++++++++++++++++-------
> >  2 files changed, 60 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> > index 59042d5ac520..70f42eef813b 100644
> > --- a/include/linux/ceph/ceph_features.h
> > +++ b/include/linux/ceph/ceph_features.h
> > @@ -165,9 +165,9 @@ DEFINE_CEPH_FEATURE(58, 1, FS_FILE_LAYOUT_V2) // overlap
> >  DEFINE_CEPH_FEATURE(59, 1, FS_BTIME)
> >  DEFINE_CEPH_FEATURE(59, 1, FS_CHANGE_ATTR) // overlap
> >  DEFINE_CEPH_FEATURE(59, 1, MSG_ADDR2) // overlap
> > -DEFINE_CEPH_FEATURE(60, 1, BLKIN_TRACING)  // *do not share this bit*
> > +DEFINE_CEPH_FEATURE(60, 1, OSD_RECOVERY_DELETES) // *do not share this bit*
> > +DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
> >
> > -DEFINE_CEPH_FEATURE(61, 1, RESERVED2)          // unused, but slow down!
> >  DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
> >  DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
> >
> > @@ -209,7 +209,8 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facin
> >          CEPH_FEATURE_SERVER_JEWEL |            \
> >          CEPH_FEATURE_MON_STATEFUL_SUB |        \
> >          CEPH_FEATURE_CRUSH_TUNABLES5 |         \
> > -        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING)
> > +        CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING | \
> > +        CEPH_FEATURE_CEPHX_V2)
> >
> >  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
> >         (CEPH_FEATURE_NOSRCADDR |        \
> > diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> > index ce28bb07d8fd..10eb759bbcb4 100644
> > --- a/net/ceph/auth_x.c
> > +++ b/net/ceph/auth_x.c
> > @@ -9,6 +9,7 @@
> >
> >  #include <linux/ceph/decode.h>
> >  #include <linux/ceph/auth.h>
> > +#include <linux/ceph/ceph_features.h>
> >  #include <linux/ceph/libceph.h>
> >  #include <linux/ceph/messenger.h>
> >
> > @@ -803,26 +804,64 @@ static int calc_signature(struct ceph_x_authorizer *au, struct ceph_msg *msg,
> >                           __le64 *psig)
> >  {
> >         void *enc_buf = au->enc_buf;
> > -       struct {
> > -               __le32 len;
> > -               __le32 header_crc;
> > -               __le32 front_crc;
> > -               __le32 middle_crc;
> > -               __le32 data_crc;
> > -       } __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
> >         int ret;
> >
> > -       sigblock->len = cpu_to_le32(4*sizeof(u32));
> > -       sigblock->header_crc = msg->hdr.crc;
> > -       sigblock->front_crc = msg->footer.front_crc;
> > -       sigblock->middle_crc = msg->footer.middle_crc;
> > -       sigblock->data_crc =  msg->footer.data_crc;
> > -       ret = ceph_x_encrypt(&au->session_key, enc_buf, CEPHX_AU_ENC_BUF_LEN,
> > -                            sizeof(*sigblock));
> > -       if (ret < 0)
> > -               return ret;
> > +       if (!CEPH_HAVE_FEATURE(msg->con->peer_features, CEPHX_V2)) {
> > +               struct {
> > +                       __le32 len;
> > +                       __le32 header_crc;
> > +                       __le32 front_crc;
> > +                       __le32 middle_crc;
> > +                       __le32 data_crc;
> > +               } __packed *sigblock = enc_buf + ceph_x_encrypt_offset();
> > +
> > +               sigblock->len = cpu_to_le32(4*sizeof(u32));
> > +               sigblock->header_crc = msg->hdr.crc;
> > +               sigblock->front_crc = msg->footer.front_crc;
> > +               sigblock->middle_crc = msg->footer.middle_crc;
> > +               sigblock->data_crc =  msg->footer.data_crc;
> > +
> > +               ret = ceph_x_encrypt(&au->session_key, enc_buf,
> > +                                    CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock));
> > +               if (ret < 0)
> > +                       return ret;
> > +
> > +               *psig = *(__le64 *)(enc_buf + sizeof(u32));
> > +       } else {
> > +               struct {
> > +                       __le32 header_crc;
> > +                       __le32 front_crc;
> > +                       __le32 front_len;
> > +                       __le32 middle_crc;
> > +                       __le32 middle_len;
> > +                       __le32 data_crc;
> > +                       __le32 data_len;
> > +                       __le32 seq_lower_word;
> > +               } __packed *sigblock = enc_buf;
> > +               struct {
> > +                       __le64 a, b, c, d;
> > +               } __packed *penc = enc_buf;
> > +               int ciphertext_len;
> > +
> > +               sigblock->header_crc = msg->hdr.crc;
> > +               sigblock->front_crc = msg->footer.front_crc;
> > +               sigblock->front_len = msg->hdr.front_len;
> > +               sigblock->middle_crc = msg->footer.middle_crc;
> > +               sigblock->middle_len = msg->hdr.middle_len;
> > +               sigblock->data_crc =  msg->footer.data_crc;
> > +               sigblock->data_len = msg->hdr.data_len;
> > +               sigblock->seq_lower_word = *(__le32 *)&msg->hdr.seq;
> > +
> > +               /* no leading len, no ceph_x_encrypt_header */
> > +               ret = ceph_crypt(&au->session_key, true, enc_buf,
> > +                                CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock),
> > +                                &ciphertext_len);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               *psig = penc->a ^ penc->b ^ penc->c ^ penc->d;
> > +       }
> >
> > -       *psig = *(__le64 *)(enc_buf + sizeof(u32));
> >         return 0;
> >  }
> 
> Hi Greg,
> 
> I thought this series (patches 13 - 18) was dropped from the 4.14 queue.
> If it wasn't, you also need to pick up the following:
> 
> f1d10e046379 libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()
> 130f52f2b203 libceph: check authorizer reply/challenge length before reading
> 
> See our discussion with Sasha:
> 
>   https://www.spinics.net/lists/stable/msg272462.html

Ah, missed that, sorry.  I've queued these patches up now, thanks!

greg k-h
