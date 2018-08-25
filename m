Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C174C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC64821581
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 01:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwyFPh3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC64821581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeHYFGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:06:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39509 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeHYFGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:06:38 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so8573733iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 18:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GLYFUksMrLJJl8xdEo5zQsPHTOFGj4tqAV7rw+tNSas=;
        b=NwyFPh3ROuhZvVO+g58uvaf/72vVb7uuECuPdZrKYsAXMu0tIbWxUvn4duLpwjA2S/
         pr6nA+8U+CljKyM7uObCdjmpubu27ld15C/hsXVayHkDwPIwbF3yISPT1cv5DmpO81IB
         GuI+vhTBBcaLPILnCkPYzz1FdtH9jvNhXHDhby26F331e1Yp/9kLHBOzPL8sV6dJyAZG
         pTdqD9GGSVAIE9bWcqgreBuLTevvv3FMQajXQ8cCKNBJEmNAPCoNaeseJ2twrMbNtLPT
         ENHnqnVlO+C8kcJUM1FYzzBpzmo8UAy506WXq9s3T1R4U9ZcwZ7MrbDKmWqp98BJUZw3
         5ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GLYFUksMrLJJl8xdEo5zQsPHTOFGj4tqAV7rw+tNSas=;
        b=MC1i1UfMDoAm5Bezv/h9BxreUN1zsepIidIwfJAFIHJp2+SzSrN/ZxoQXm7SzrKPJi
         wF/pjLgQsIcGBO9k7qkxs2UUwuwzW/1pMRkH4gIyoh7cFoAHZX2kKsf2+bkwEsmTBVKB
         NWEm0MIukdlLC0XC1GwCMpZq9f10q16x97KExAvgsGG+mrstVRvXPa786jhoBr74qxpw
         pQsjPsgFLT7Q/HCSbhw73tIO59USgb8KfOYCjOvSyu6TN0V48/40RkpENiXgZQ6o6THs
         sv5ZK03MjrN+9istPYegyLORxQls4KLA0xU+ivcnT5g9biJkKyq0FDtQH3p3lRFXgav0
         X1Ug==
X-Gm-Message-State: APzg51DtVHg1dtj2RwhR91+dKBJvUAMhYeStQ+V+LuPwPvM7fWAc3ele
        BTQW95uUnOi+XQm49BTBD9009cFN6x1g9gm4pUwhGeeXPjY=
X-Google-Smtp-Source: ANB0VdZPKb9QX5HWEAQkpvY9DFbgWR5yFrtVvr04MYEjn3Sg8mH/3OxBvGEP5CyjwqfiIVJvsxpwjSErO1XA6Vdyg84=
X-Received: by 2002:a6b:c694:: with SMTP id w142-v6mr2975575iof.142.1535160573530;
 Fri, 24 Aug 2018 18:29:33 -0700 (PDT)
MIME-Version: 1.0
From:   xin tan <tanxin0725@gmail.com>
Date:   Sat, 25 Aug 2018 09:29:22 +0800
Message-ID: <CAPt3h3XTjAY5v-_-VB2ud8wHQUDcRe8hjhHzW+03=j08zPbh6w@mail.gmail.com>
Subject: Ask for your comment for our research: Reducing the Workload of the
 Linux Kernel Maintainers: Multiple-Committer Model
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am a Ph.D. student from China. Our research team is dedicated to
helping FLOSS ecosystems have healthy and sustainable development. The
Linux kernel is one of the key study cases for us because as a
prominent FLOSS project, the Linux kernel has many unique practices.
Recently, we observed that increasing numbers of contributors to the
Linux kernel have concerns regarding whether the development process
(workflow) can handle the current mass of patches and even more
patches in the future. While the workflow gives maintainers many
rights, it also places significant pressure on them, which bears the
risk of a single point of failure. We investigated the effect of a new
model, the multiple-committer model, which is currently used by the
i915 subsystem to alleviate the burden on its maintainer. We find that
this model can reduce the proportion of the review workload of the
busiest maintainer, reduce the review latency and maintainers'
overwork, and simplify the review network. The review process is
strictly enforced to guarantee the quality of patches. Subsystems with
usage demands, mechanisms for ensuring patch quality, and candidate
committers are suitable for the model. Sufficient precommit testing, a
strict review process, necessary documentation, and the use of
automatic tools are important practices to follow when applying the
model.
We hope our work would help other subsystems extract valuable
information and optimize their workflow to achieve a more efficient
review process and sustain themselves in a constantly changing,
complicated environment. We uploaded the draft paper at
"https://github.com/SunflowerPKU/Reducing-the-Workload-of-the-Linux-Kernel-Maintainers-Multiple-Committer-Model/blob/master/reduce-workload-linux.pdf".
If you are interested in this topic, please take a moment to
understand our work. We are looking forward to your comments and
suggestions.

Best regard,
Xin Tan
