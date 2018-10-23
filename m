Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2519DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCCB20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9Ib3/7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCCB20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeJXDym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:54:42 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38114 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:54:42 -0400
Received: by mail-yw1-f67.google.com with SMTP id d126-v6so1043558ywa.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RfZJuuwcXtDyzwU+cMqX16BOa4nez+G5Q0N/dnglgHo=;
        b=I9Ib3/7IxEs3kP2LbMWGvHdxSFxHzhoGmck4nRCh/0TW8TpFsL6/7CLZGUKRSGRvD3
         EhSNxNLGFjtxJFNm+hwpMZ6D2j3xaFnZahISNKh7jBMRODH8w1Pk+kumzadkWTaLk07Z
         RW2qBNyxihMsHa4uqIF6Kxw/BRxKVRpmd7Pbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RfZJuuwcXtDyzwU+cMqX16BOa4nez+G5Q0N/dnglgHo=;
        b=jZpUS2ur5saXw7lk0ijbTBTs8aIgx6hTBBBhm81Zxerl9ahJ/c+4RVk3KmDlEg5Rm+
         a8YyxAYjr7gEbRxE0GPxcTj63F1WEHQGJu5bpsJvTNM+VyqDSK1Ko6K8YdKR8eooKXsc
         bbE+EdkmCn1WcRjgcSFqMvvCGEd3mBPkdtjt9h53LKcRubIhGLjOLRBvZ1dXZkPNqhxD
         sQi5xRtYZMa9MppOUyGMCms0ECVeIoYQSZoM4Z7VeuUvCc3CWP8sP5+L//4yT8FDf2Kd
         7OfyEFTOWjnGvkkY66SV2OmWq64po6rA3FFGdgDGfjWnIG1Qu96CynvSwE31sRfxWHzt
         Ix9w==
X-Gm-Message-State: AGRZ1gK1whicGVNDVOjLplft4Bx1nZ30cEDcThZZk0qirWkZN3a2X8/r
        pjRGsdC1lJ+uTMLszIBhCbA+vf0auvk=
X-Google-Smtp-Source: AJdET5drYVxRMgKypaqsciXAkKn5MUY/rFj1z8KsdaEW6b+qCBx0KFaFCq8Y+7S0bM3TqjTNzZVsRg==
X-Received: by 2002:a0d:e146:: with SMTP id k67-v6mr1552524ywe.78.1540322995108;
        Tue, 23 Oct 2018 12:29:55 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id 138-v6sm510612yws.28.2018.10.23.12.29.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:29:53 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j75-v6so1039807ywj.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 12:29:53 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr37414684ywg.353.1540322993174;
 Tue, 23 Oct 2018 12:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 12:29:52
 -0700 (PDT)
In-Reply-To: <20181023111749.1581-1-efremov@linux.com>
References: <20181023111749.1581-1-efremov@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 12:29:52 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK6-t-WGPMhZn4QtvLaBQPFrRFtT95kvVZFWJ33wVXDwg@mail.gmail.com>
Message-ID: <CAGXu5jK6-t-WGPMhZn4QtvLaBQPFrRFtT95kvVZFWJ33wVXDwg@mail.gmail.com>
Subject: Re: [PATCH] security: fix documentation for the audit_* hooks
To:     efremov@linux.com
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:17 AM,  <efremov@linux.com> wrote:
> From: Denis Efremov <efremov@linux.com>
>
> This patch makes argument names equal in the documentation and
> declarations of the audit_* hooks.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 596351f7c3d1..9fb67c212298 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1329,7 +1329,7 @@
>   * @audit_rule_known:
>   *     Specifies whether given @rule contains any fields related to
>   *     current LSM.
> - *     @rule contains the audit rule of interest.
> + *     @krule contains the audit rule of interest.
>   *     Return 1 in case of relation found, 0 otherwise.
>   *
>   * @audit_rule_match:
> @@ -1338,14 +1338,14 @@
>   *     @secid contains the security id in question.
>   *     @field contains the field which relates to current LSM.
>   *     @op contains the operator that will be used for matching.
> - *     @rule points to the audit rule that will be checked against.
> + *     @lsmrule points to the audit rule that will be checked against.
>   *     @actx points to the audit context associated with the check.
>   *     Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
>   *
>   * @audit_rule_free:
>   *     Deallocate the LSM audit rule structure previously allocated by
>   *     audit_rule_init.
> - *     @rule contains the allocated rule
> + *     @lsmrule contains the allocated rule.
>   *
>   * @inode_invalidate_secctx:
>   *     Notify the security module that it must revalidate the security context
> --
> 2.17.2
>



-- 
Kees Cook
