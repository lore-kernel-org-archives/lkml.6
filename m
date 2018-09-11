Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82784C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6392086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRduqyJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A6392086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIKOII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:08:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35369 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbeIKOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:08:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so20240824ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vdVlnUzJtm5pEstycq/Rk8rhXbVcRAJrU61obM0wfUM=;
        b=TRduqyJtihJlzTpcyN5ZkrXo8hFswui56Grlv8nxzxaCLxGTD+XX6MCyOMi+qmPUM7
         RZVXRGv6aDZpj2QXo7vx+E9Dq9SLnMi42F0RN6f8CytUbHQqz8x9cA+TH0CJJ88MXjQa
         tIsWdwWNMusj8NkhK0nlsVmnpCjKmGaublIds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vdVlnUzJtm5pEstycq/Rk8rhXbVcRAJrU61obM0wfUM=;
        b=Mqc6o0IsPb231O+28DY5ALDyfOa3uZp4FtR+0RvZaJI3TubmjtIDiTgACikRS8iExT
         v9EbvuG+EOHeVVzUO4eZbghqDtNoARVcXiI1L9txuD/33nvu44M2mXc5KXZnOyN4fpAp
         bVE6W13uNcmlJwPYPsPvWR9e5iE62C9bxKmk+/1aecffr0hOOP0Hstl2anFtk804k86N
         9GtWrAZBO+MsoryeXJizyIscRFqvFBKdaZayCdWcW57X5HluZ8M7sLlNM+XV3vco8XGo
         gsO/aBZFDvOVCNk8kGfjwnOAs8WyzY83gb0/tMvfGRdJroMiLzjwqKpE5M/LZj4CPFoH
         2NHQ==
X-Gm-Message-State: APzg51CuoqtAYXCKRn8nsR5Fqp5lcD0ay42wZClIELkHz/GxeI3I2toG
        3zJM1RQFfn3s8PmYtUQ/EVoiyXUQkF72Pwet0QDZBQ==
X-Google-Smtp-Source: ANB0VdZNY50GCIqW6dnF5NRxOOocgptwY95M0sysWZa7O54ywYQuJT9GiqbNhwOkoPfUW6bpYZMuZO6tnrfCsH/F4wA=
X-Received: by 2002:a2e:934d:: with SMTP id m13-v6mr1002360ljh.45.1536656983685;
 Tue, 11 Sep 2018 02:09:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:118f:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 02:09:02
 -0700 (PDT)
From:   Victor Chong <victor.chong@linaro.org>
Date:   Tue, 11 Sep 2018 18:09:02 +0900
Message-ID: <CAHqM-Qjr+5T1pMatJ=5MSsJvzaRqPybt_2TtyzHPwLnt=WjCEA@mail.gmail.com>
Subject: [PATCH v2] tee: optee: log message if dynamic shm is enabled
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dynamic shared memory support is enabled in the OP-TEE Trusted
OS, it doesn't mean that the driver supports it, which can confuse
users during debugging. Log a message when dynamic shared memory is
enabled in the driver, to let users know for sure.

Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Victor Chong <victor.chong@linaro.org>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---

v2:
* Added patch description

[v1] lore.kernel.org/patchwork/patch/983949/

 drivers/tee/optee/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe842d66..cca5c091e55a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -631,6 +631,9 @@ static struct optee *optee_probe(struct device_node *np)

        optee_enable_shm_cache(optee);

+       if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
+               pr_info("dynamic shared memory is enabled\n");
+
        pr_info("initialized driver\n");
        return optee;
 err:
--
2.17.1
