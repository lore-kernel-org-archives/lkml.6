Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15491C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2554E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbeLNPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:31:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbeLNPb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:31:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FF34C05D3ED;
        Fri, 14 Dec 2018 15:31:29 +0000 (UTC)
Received: from redhat.com (ovpn-121-101.rdu2.redhat.com [10.10.121.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA52F60635;
        Fri, 14 Dec 2018 15:31:28 +0000 (UTC)
Date:   Fri, 14 Dec 2018 10:31:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vhost: accelerate metadata access through
 vmap()
Message-ID: <20181214102436-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213102315-mutt-send-email-mst@kernel.org>
 <9459e227-a943-8553-732b-d7f5225a0f22@redhat.com>
 <20181214072334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214072334-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 14 Dec 2018 15:31:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:33:20AM -0500, Michael S. Tsirkin wrote:
> > - unsafe_put_user/unsafe_get_user is not sufficient for accessing structures
> > (e.g accessing descriptor) or arrays (batching).
> 
> So you want unsafe_copy_xxx_user? I can do this. Hang on will post.

Like this basically? Warning: completely untested.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index b5e58cc0c5e7..d2afd70793ca 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -728,5 +728,10 @@ do {										\
 	if (unlikely(__gu_err)) goto err_label;					\
 } while (0)
 
+#define unsafe_copy_from_user(to, from, n)					\
+	 __copy_user_ll(to, (__force const void *)from, n)
+#define unsafe_copy_to_user(to, from, n)					\
+	 __copy_user_ll((__force void *)to, from, n)
+
 #endif /* _ASM_X86_UACCESS_H */
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index efe79c1cdd47..b9d515ba2920 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -271,6 +271,8 @@ extern long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count);
 #define user_access_end() do { } while (0)
 #define unsafe_get_user(x, ptr, err) do { if (unlikely(__get_user(x, ptr))) goto err; } while (0)
 #define unsafe_put_user(x, ptr, err) do { if (unlikely(__put_user(x, ptr))) goto err; } while (0)
+#define unsafe_copy_to_user(from, to, n) copy_to_user(from, to, n)
+#define unsafe_copy_from_user(from, to, n) copy_from_user(from, to, n)
 #endif
 
 #ifdef CONFIG_HARDENED_USERCOPY
