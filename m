Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152B8C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C064B20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwyTxGO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C064B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeKHJul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbeKHJul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:50:41 -0500
Received: from localhost (unknown [131.107.159.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A6C20857;
        Thu,  8 Nov 2018 00:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541636272;
        bh=/TeVOT9uEuMGIn9YlWXqGjgokwKVf/7Py4uaskdDfaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwyTxGO2PpJyl7En5iag/TwUaP3CnrSN6Lf1IH1jMLh8MyUL74q3xJTNELp6bCbD1
         cLdA5wkvRBulfaXQhDDlUfvUGqUVv2jb9AWbtliKiEERq84il0JwRW6o8ZFqs27a0z
         3NTOA994uZV6VBMwWIZ0epSl3/j2p2lltnF+icNo=
Date:   Wed, 7 Nov 2018 19:17:51 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [stable, netdev 4.4+] lan78xx: make sure RX_ADDRL &
 RX_ADDRH regs are always up to date
Message-ID: <20181108001751.GA8097@sasha-vm>
References: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1541609457-28725-1-git-send-email-p.pisati@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 05:50:57PM +0100, Paolo Pisati wrote:
>[partial backport upstream 760db29bdc97b73ff60b091315ad787b1deb5cf5]
>
>Upon invocation, lan78xx_init_mac_address() checks that the mac address present
>in the RX_ADDRL & RX_ADDRH registers is a valid address, if not, it first tries
>to read a new address from an external eeprom or the otp area, and in case both
>read fail (or the address read back is invalid), it randomly generates a new
>one.
>
>Unfortunately, due to the way the above logic is laid out,
>if both read_eeprom() and read_otp() fail, a new mac address is correctly
>generated but is never written back to RX_ADDRL & RX_ADDRH, leaving the chip in an
>incosistent state and with an invalid mac address (e.g. the nic appears to be
>completely dead, and doesn't receive any packet, etc):
>
>lan78xx_init_mac_address()
>...
>if (lan78xx_read_eeprom(addr ...) || lan78xx_read_otp(addr ...)) {
>	if (is_valid_ether_addr(addr) {
>		// nop...
>	} else {
>		random_ether_addr(addr);
>	}
>
>	// correctly writes back the new address
>	lan78xx_write_reg(RX_ADDRL, addr ...);
>	lan78xx_write_reg(RX_ADDRH, addr ...);
>} else {
>	// XXX if both eeprom and otp read fail, we land here and skip
>	// XXX the RX_ADDRL & RX_ADDRH update completely
>	random_ether_addr(addr);
>}
>
>This bug went unnoticed because lan78xx_read_otp() was buggy itself and would
>never fail, up until 4bfc338 "lan78xx: Correctly indicate invalid OTP"
>fixed it and as a side effect uncovered this bug.
>
>4.18+ is fine, since the bug was implicitly fixed in 760db29 "lan78xx: Read MAC
>address from DT if present" when the address change logic was reorganized, but
>it's still present in all stable trees below that: linux-4.4.y, linux-4.9.y,
>linux-4.14.y, etc up to linux-4.18.y (not included).
>
>Signed-off-by: Paolo Pisati <p.pisati@gmail.com>

So why not just take 760db29bdc completely? It looks safer than taking a
partial backport, and will make applying future patches easier.

I tried to do it and it doesn't look like there are any dependencies
that would cause an issue.

--
Thanks,
Sasha
