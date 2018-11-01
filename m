Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D7C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822A7205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcW3Bm/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822A7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeKBC0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:26:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43547 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeKBC0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:26:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id u18so14739885lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5CPG5/MAt5dtPdWlNMCRHHM+n5fvu8fNVtIfISuNiE=;
        b=NcW3Bm/BY0w7sCKRZ7u+enScTnW6fM2GkCrk8WjcLAXCCKysfdvZcrLghjxBiehPuG
         QAP27+uVa2FGdMnDl+b/xOi0TOR99aUKBvjvrjdedC1zIneKBW9qNUNgXYuyP+9va2Ny
         PQ/qmeewjojpQ0+Gb7v6ksBlAmZWkKnRiFOic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5CPG5/MAt5dtPdWlNMCRHHM+n5fvu8fNVtIfISuNiE=;
        b=eNd4OsO0tjk6XZMm71ajHvnnwPO0B0p/JK/9OS/5WpKuoQhx6uJ5QRLIASypp/rWKk
         t18LEHdjNdCKWJjegJ3/67Cd7kIcBmJGJUSDhmETp9rraqHl5WxSVZQ0qeNsXdVwIN4m
         t4WilueA5S0IyPcRBSa+tsMLMyGBoUQDZbU5L+aHBdwAj++3YGkQodQa2eInhl2NN2bu
         ksnwMvPETZ19ZHXANP7WncooNtPTDhvBYfaCm4/1iIO+aetpdrw5GZ+akwxKJ6lX7VRQ
         rC8TcRCQidZ1V2weVMtz9elPuqA1pDp5LzcoIkTf6sJmDJKihM4vr67wKy9Pewz+2hMi
         5wRg==
X-Gm-Message-State: AGRZ1gIHfVqJq4kavojfmuEaWzBOflQFRfYzkf5473u9aGhr19d3/GUY
        1TkjgbYhJUa41eqlna/SayNqQYMUwqg=
X-Google-Smtp-Source: AJdET5fk2FIFOIhwH2C+Aheo7l/TsCsfX1D4ZtYY2Fh6dwjRb96iijLakFJNT9Ja2kiqITGVE0B/Pw==
X-Received: by 2002:a19:be16:: with SMTP id o22mr4873077lff.22.1541092928276;
        Thu, 01 Nov 2018 10:22:08 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r199sm2137860lff.50.2018.11.01.10.22.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:22:05 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id p17so8294824lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 10:22:04 -0700 (PDT)
X-Received: by 2002:a19:a60c:: with SMTP id p12mr2092425lfe.63.1541092924434;
 Thu, 01 Nov 2018 10:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
In-Reply-To: <1540920209-28954-1-git-send-email-rplsssn@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Nov 2018 10:21:27 -0700
X-Gmail-Original-Message-ID: <CAE=gft59UWM4=WhLkcLR3+FCEeD5OVwaJjZ8w_t=Fgtt=vFFpA@mail.gmail.com>
Message-ID: <CAE=gft59UWM4=WhLkcLR3+FCEeD5OVwaJjZ8w_t=Fgtt=vFFpA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: Add PSCI cpuidle low power states
To:     rplsssn@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:23 AM Raju P.L.S.S.S.N
<rplsssn@codeaurora.org> wrote:
>
> Add device bindings for cpuidle states for cpu devices.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> ---
> Changes in v2
>  - Address comments from Doug
> ---
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
