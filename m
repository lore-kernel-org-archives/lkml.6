Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeB0XQE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:16:04 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:38862 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeB0XQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:16:01 -0500
X-Google-Smtp-Source: AG47ELsol9oCS/NgbxXrNsALsEPIK87I2cEkHhu6TeOQ4zu2ggVtcYa7oG08dR1LIaP3AU2rgV9VyQ==
Date: Tue, 27 Feb 2018 17:15:59 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] i2c: qup: fix buffer overflow for multiple msg of
 maximum xfer len
Message-ID: <20180227231559.GJ20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517644697-30806-10-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:14PM +0530, Abhishek Sahu wrote:
> The BAM mode requires buffer for start tag data and tx, rx SG
> list. Currently, this is being taken for maximum transfer length
> (65K). But an I2C transfer can have multiple messages and each
> message can be of this maximum length so the buffer overflow will
> happen in this case. Since increasing buffer length won’t be
> feasible since an I2C transfer can contain any number of messages
> so this patch does following changes to make i2c transfers working
> for multiple messages case.
> 
> 1. Calculate the required buffers for 2 maximum length messages
>    (65K * 2).
> 2. Split the descriptor formation and descriptor scheduling.
>    The idea is to fit as many messages in one DMA transfers for 65K
>    threshold value (max_xfer_sg_len). Whenever the sg_cnt is
>    crossing this, then schedule the BAM transfer and subsequent
>    transfer will again start from zero.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

I'm ok with this patch.  I find the idea of a > 64k size message to be something
that usually wouldn't be encountered, but... with some eeproms and maybe TPMs
perhaps this could happen?

Reviewed-by: Andy Gross <andy.gross@linaro.org>
