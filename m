Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E687C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4604F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clA70rPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4604F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbeIFW7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:59:43 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33665 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeIFW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:59:43 -0400
Received: by mail-oi0-f49.google.com with SMTP id 8-v6so22437405oip.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eKdC3kL6lGzjZixCtLqgSWHC+raQs25fIAOiHCVjhAg=;
        b=clA70rPFevptjvEPc2bs+bjJv4LF7clgD3rEjTirTPu9PifeJFjt6VMAXTGhS7MCAJ
         cEn3jzzi77fMBQZdyHQGKoUee85tDNXc8x4xkuSMOluy2ypMnNwgsIy5ZqHNLGG6VEWX
         hYDt2kZRInYyldnGkejiHpNZAYRJ1a+cgJzNsv2v28D3YpTM7lj5DHqFe/Xs8ooKYprT
         0s0zZ62pByHq4oApdQrKuEmRtuk5sY6xJWM8pX5q7SiOUedc6/goOUEER1/w0iJpofrG
         CBVml+ieAYmCyQEc0uGTks7LlQ1xQnYM+zih5R9SrwOZrAtueQb09pavm+Lr8vA0TCq+
         ixPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eKdC3kL6lGzjZixCtLqgSWHC+raQs25fIAOiHCVjhAg=;
        b=YLWgk5xtLRdbfgBSuzKsm02dzxU2GxgCHG21ME8YoTRufENjOIX64k5ditgXN8KGNi
         f6N1YNWv3d9Dy07wH7jLVoGGx4VSRD3jbyOdl4CAcv1xGEL2//qPH90oNL58mYqiyC7B
         oz7Hczmgf3Dr8cKnP1rF08BE3DlEpzNYteyPSwm0uPMJn2mGT49L5XicjnjtTLz9ZG2o
         2mDhmR79ntQpUolObbJV1YTrQeCvu3ho8YE6xRafdRYSLUwV7VB03eFYU/A7g4qjqTxj
         RLyA9Lit47IINRw92LpHbcLkQPpod4JBsHcmlA/dX82sJpny2M966xjZFWBKbFy7iFdk
         lGlg==
X-Gm-Message-State: APzg51CgH4ZD0CfGwsIsq5xzAeUwxupl0YHKNlqhqn2TyPc1Kapz7PM3
        QlCJbBOq0yyMQtXHPThOfhlQKXOHnrDz7V78HYbrl8SjKos=
X-Google-Smtp-Source: ANB0VdbzPvP8YH/iPsMmQEg/0TF5LP2/PfKz88XuCA4q+Y/HaGLPKAxuPEv7LDbP9u8+wjjDaNEbAd01ohVwFYgYSM0=
X-Received: by 2002:aca:c585:: with SMTP id v127-v6mr4180380oif.348.1536258182130;
 Thu, 06 Sep 2018 11:23:02 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Thu, 6 Sep 2018 20:22:35 +0200
Message-ID: <CAG48ez0nCC0_on95q7x_8cwSyJ8ATReA0ysDnEr=CW2tkqE=7w@mail.gmail.com>
Subject: Smack: wrong-looking capable() check in smk_ptrace_rule_check()
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed the following check in smk_ptrace_rule_check():

                if (tracer_known->smk_known == tracee_known->smk_known)
                        rc = 0;
                else if (smack_ptrace_rule == SMACK_PTRACE_DRACONIAN)
                        rc = -EACCES;
                else if (capable(CAP_SYS_PTRACE))
                        rc = 0;
                else
                        rc = -EACCES;

Note that smk_ptrace_rule_check() can be called from not just
smack_ptrace_access_check() and smack_ptrace_traceme(), but also
smack_bprm_set_creds(). AFAICS this means that if a task executes with
a smack privilege transition and smack_ptrace_rule is
SMACK_PTRACE_EXACT, whether the execution is permitted depends on
whether _the debugged task_ has CAP_SYS_PTRACE (and not on whether the
debugger has that capability).
This seems like it's probably unintentional?
