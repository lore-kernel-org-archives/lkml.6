Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD285C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA19218E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA19218E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbeHNJsj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:48:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49361 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731066AbeHNJsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:48:38 -0400
Received: from marcel-macpro.fritz.box (p4FEFCC41.dip0.t-ipconnect.de [79.239.204.65])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1291ACEFA2;
        Tue, 14 Aug 2018 09:09:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180813220419.4168133-1-arnd@arndb.de>
Date:   Tue, 14 Aug 2018 09:02:46 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeremy Cline <jeremy@jcline.org>,
        Kees Cook <keescook@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8F488B14-4425-44A4-9E6D-58513FED5256@holtmann.org>
References: <20180813220419.4168133-1-arnd@arndb.de>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
> warning because of an incorrect set of #ifdef guards:
> 
> drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]
> 
> Replacing the #ifdef with an IS_ENABLED() check shuts up the error
> and simplifies the logic.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/hci_h5.c | 10 +++-------
> 1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..b10e64ba0ff4 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -841,7 +841,6 @@ static void h5_serdev_remove(struct serdev_device *serdev)
> 	hci_uart_unregister_device(&h5->serdev_hu);
> }
> 
> -#ifdef CONFIG_BT_HCIUART_RTL
> static int h5_btrtl_setup(struct h5 *h5)
> {
> 	struct btrtl_device_info *btrtl_dev;
> @@ -923,24 +922,21 @@ static struct h5_vnd rtl_vnd = {
> 	.close		= h5_btrtl_close,
> 	.acpi_gpio_map	= acpi_btrtl_gpios,
> };
> -#endif
> 
> -#ifdef CONFIG_ACPI
> static const struct acpi_device_id h5_acpi_match[] = {
> -#ifdef CONFIG_BT_HCIUART_RTL
> 	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
> -#endif
> 	{ },
> };
> MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
> -#endif
> 
> static struct serdev_device_driver h5_serdev_driver = {
> 	.probe = h5_serdev_probe,
> 	.remove = h5_serdev_remove,
> 	.driver = {
> 		.name = "hci_uart_h5",
> -		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> +		.acpi_match_table = (IS_ENABLED(CONFIG_BT_HCIUART_RTL) &&
> +				     IS_ENABLED(CONFIG_ACPI)) ?
> +					h5_acpi_match : 0,
> 	},

I do not like this construct at all. It will also blow up once we have a second vendor with H:5 support. We need to find another way to solve this.

Regards

Marcel

