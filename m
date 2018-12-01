Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5337EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E9E20867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TIZxmPfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E9E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLAL6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:58:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44868 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbeLAL6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:58:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so5353982lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhmAcOfQHba7jsByZTi1TgDT9pcdTkIHC+NZgrhuRHg=;
        b=TIZxmPfJFbaNypWYoxkmT7u0IVQMKTmwtE7J+QMhCk/Z+8baz4+ZF51fWhiwYwp5mf
         2QxIOGE3EmUWTZxW8NXE3rek2uH5buBY2CNYhAzhOBit4GItPdfAM0NmB+LDyV7olbrM
         aWaLNAeZrx3dGsUR2SxQoc1Zgj7L+hdF+6RmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhmAcOfQHba7jsByZTi1TgDT9pcdTkIHC+NZgrhuRHg=;
        b=UY7U4hzXbpGsoEGWemGVVkm9vakk7/b7pHrwFvOHATUV0BSjwCpO4Z2aU32V71ESLJ
         KEfzRf/hNoM5NZUqVUvDaYvqzcs2OAE6KtqSxWcRtPAIGMhpQ+5Ihuu3AGIPXatg1E+e
         dYYR8DcU0reir0WHv37VPpbT6TigAb7g4KD3/Y7Ow+SXHK9AAZoiVfhd8FjA+6a5MBIi
         ZPnA6Xkx6bcDbvoxleWExK5DvQLeDeURmMR1ol4IgCx7fiZam/Jx8BpR8KkFVID6FGji
         gx8uWPAWH2Vk+Rhp7BWx/VGefXKTQF1SXwbtJ/TFkPXGtNfOLdAORpc7oXi7eJ1Rdf5/
         6L/g==
X-Gm-Message-State: AA+aEWaxk/e6UM9EecFBmDlgcCy4q1ilHrBWDlarfZvi9A349MdjlVJs
        4UA4gC/C+auFoyOspFfEfbA/ZUPbebE=
X-Google-Smtp-Source: AFSGD/VWhy3k+OEFdvOVayhKAFrEtN1D6b7dnA/kV138HpOPuZkWf4A6PRoQvcM1qHAFtthnGMywnw==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr5026226lfi.3.1543625253423;
        Fri, 30 Nov 2018 16:47:33 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p91sm1092396lfg.4.2018.11.30.16.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 16:47:33 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id p86so5374577lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 16:47:33 -0800 (PST)
X-Received: by 2002:a19:1bca:: with SMTP id b193mr4641734lfb.153.1543624776451;
 Fri, 30 Nov 2018 16:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20181127180349.29997-1-georgi.djakov@linaro.org> <20181127180349.29997-6-georgi.djakov@linaro.org>
In-Reply-To: <20181127180349.29997-6-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 30 Nov 2018 16:39:00 -0800
X-Gmail-Original-Message-ID: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Message-ID: <CAE=gft4tO96n0vAubo1_vvcTO4yarDcTNOTuL6cLpmLDDNxrfA@mail.gmail.com>
Subject: Re: [PATCH v10 5/7] interconnect: qcom: Add sdm845 interconnect
 provider driver
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>,
        maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>,
        thierry.reding@gmail.com, ksitaraman@nvidia.com,
        sanjayc@nvidia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:04 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> From: David Dai <daidavid1@codeaurora.org>
>
> Introduce Qualcomm SDM845 specific provider driver using the
> interconnect framework.
>
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sdm845.txt     |  24 +
>  drivers/interconnect/Kconfig                  |   5 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/qcom/Kconfig             |  13 +
>  drivers/interconnect/qcom/Makefile            |   5 +
>  drivers/interconnect/qcom/sdm845.c            | 836 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm845.h    | 143 +++
>  7 files changed, 1027 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
>  create mode 100644 drivers/interconnect/qcom/Kconfig
>  create mode 100644 drivers/interconnect/qcom/Makefile
>  create mode 100644 drivers/interconnect/qcom/sdm845.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm845.h
>
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> new file mode 100644
> index 000000000000..d45150e99665
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> @@ -0,0 +1,24 @@
> +Qualcomm SDM845 Network-On-Chip interconnect driver binding
> +-----------------------------------------------------------
> +
> +SDM845 interconnect providers support system bandwidth requirements through
> +RPMh hardware accelerators known as Bus Clock Manager(BCM). The provider is able
> +to communicate with the BCM through the Resource State Coordinator(RSC)
> +associated with each execution environment. Provider nodes must reside within
> +an RPMh device node pertaining to their RSC and each provider maps to
> +a single RPMh resource.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +                       "qcom,sdm845-rsc-hlos"

I wonder if maybe hlos isn't necessary. Unless you somehow imagine
secure mode would have a device tree entry in here as well? Probably
not.

> +- #interconnect-cells : should contain 1
> +
> +Examples:
> +
> +apps_rsc: rsc {
> +               qnoc: qnoc-rsc-hlos {
> +                       compatible = "qcom,sdm845-rsc-hlos";
> +                       #interconnect-cells = <1>;
> +               };
> +};
> +
...
> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
> new file mode 100644
> index 000000000000..1678de91ca52
> --- /dev/null
> +++ b/drivers/interconnect/qcom/sdm845.c
> @@ -0,0 +1,836 @@
...
> +
> +static void tcs_list_gen(struct list_head *bcm_list,
> +                        struct tcs_cmd *tcs_list, int *n)

We could make the prototype of this function be:

static void tcs_list_gen(struct list_head *bcm_list,
        struct tcs_cmd tcs_list[SDM845_MAX_VCD], int n[SDM845_MAX_VCD])

which would catch errors if somebody later passed in an array that
wasn't the right size, since we blindly memset below.

> +{
> +       struct qcom_icc_bcm *bcm;
> +       bool commit;
> +       size_t idx = 0, batch = 0, cur_vcd_size = 0;
> +
> +       memset(n, 0, sizeof(int) * SDM845_MAX_VCD);
> +
> +       list_for_each_entry(bcm, bcm_list, list) {
> +               commit = false;
> +               cur_vcd_size++;
> +               if ((list_is_last(&bcm->list, bcm_list)) ||
> +                   bcm->aux_data.vcd != list_next_entry(bcm, list)->aux_data.vcd) {
> +                       commit = true;
> +                       cur_vcd_size = 0;
> +               }
> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
> +                           bcm->addr, commit);
> +               idx++;
> +               n[batch]++;
> +               /*
> +                * Batch the BCMs in such a way that we do not split them in
> +                * multiple payloads when they are under the same VCD. This is
> +                * to ensure that every BCM is committed since we only set the
> +                * commit bit on the last BCM request of every VCD.
> +                */
> +               if (n[batch] >= MAX_RPMH_PAYLOAD) {
> +                       if (!commit) {
> +                               n[batch] -= cur_vcd_size;
> +                               n[batch + 1] = cur_vcd_size;
> +                       }
> +                       batch++;
> +               }
> +       }
> +}
> +
