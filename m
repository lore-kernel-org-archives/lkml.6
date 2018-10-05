Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84468C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329AD206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OSwdnrD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329AD206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeJFGTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:19:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39350 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJFGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:19:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so5341765pgv.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yt3lMyj3e/yJLq7o3wY2Jk6Tj4WKurWoSIB/tjxKVZ8=;
        b=OSwdnrD23zRhLS4qDxw0b26fg4e6SPBHtMNHFQOc4lW1ik9BmZsM/Asi3qvpucF+aW
         Qcz77Hwjtz9idE/IQzr5FHdfQLRoDxkC2uWyqJ4Qa/uiIHKwl+zeiY2dBaM5CMJ8ZZHj
         FLUMK/7ZddexRfjjf30ouojRoxi3oLWsrrD3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yt3lMyj3e/yJLq7o3wY2Jk6Tj4WKurWoSIB/tjxKVZ8=;
        b=naO3+rUBx9UKw+JRMN2AEUoia5FxSJrYvUvOGsDU9IuetXIOvxEt0cLVg2Mz5t6joB
         9AZUYTYT/gw8yhxZ8TBiP1yFpnMFhXEFsZ/WiPj1CEzl+DAMoX8YPW34i5s9mcUh70qi
         WNS/yalXwhgThMa95og3suezqs8KwpMRdpdChsoJpIqJDz78suA9RBRCeP3FxH7addwo
         CTkSKBtFHvfrRH70LycUfP3GDUDngSestjdVfpowgHZP5CvDW02OcR3NS7gztJCa2v8b
         jNAVQWJww/+WQ05EgwNE1IzbKNf2RwZ3LojM5OypV5zb8ywNPiVXuRT3ILrlFbiZJYTB
         izFA==
X-Gm-Message-State: ABuFfoiNfJivsN/fevyu6TTbZSAUFkX1gKbxFDKIOzhHU57/QZZUYuuJ
        f2sADrJQRo3C75f2rir0C02AHbPdjlg=
X-Google-Smtp-Source: ACcGV63OJoNuNIFzPRV5cfmYndQb6dEx+VWJ7N9JI9A3QuoyCMVqai8jPmq/9IRkEpD2VYSN1c5HSQ==
X-Received: by 2002:a63:1411:: with SMTP id u17-v6mr11860703pgl.247.1538781507628;
        Fri, 05 Oct 2018 16:18:27 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q76-v6sm16641028pfa.18.2018.10.05.16.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 16:18:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, pantin@google.com
Subject: [PATCH RFC 0/5] rcu doc updates for whatisRCU and checklist
Date:   Fri,  5 Oct 2018 16:18:09 -0700
Message-Id: <20181005231815.170433-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Here are this week's rcu doc updates based on combing through whatisRCU and
checklists. Hopefully you agree with them. I left several old _bh and _sched
API references as is, since I don't think its a good idea to remove them till
the APIs themselves are removed, however I did remove several of them as well
(like in the first patch in this series) since I feel its better to "encourage"
new users not to use the old API.

Also do you think it makes sense for us to write coccinelle patches to check if
folks use them on new patches? Btw, I am new to coccinelle but I'd love to give
it a try, it looks exciting. I remember you saying you wanted to do that, so
that's something else you could potentially offload to me as you see fit ;-)

Thank you very much!

Joel Fernandes (Google) (5):
  doc: rcu: Update core and full API in whatisRCU
  doc: rcu: Add more rationale for using rcu_read_lock_sched in
    checklist
  doc: rcu: Remove obsolete suggestion from checklist
  doc: rcu: Remove obsolete checklist item about synchronize_rcu usage
  doc: rcu: Encourage use of rcu_barrier in checklist

 Documentation/RCU/checklist.txt | 49 +++++++----------------------
 Documentation/RCU/whatisRCU.txt | 55 +++++++++++++++++----------------
 2 files changed, 39 insertions(+), 65 deletions(-)

-- 
2.19.0.605.g01d371f741-goog
