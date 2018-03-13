Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbeCMVJG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:09:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932372AbeCMVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:09:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A7C2602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=austinwc@codeaurora.org
Subject: Re: [PATCH v2 00/13] Major code reorganization to make all i2c
 transfers working
To: Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
From: "Christ, Austin" <austinwc@codeaurora.org>
Message-ID: <2a092d8f-6d1a-27e4-01f6-49790f767ae6@codeaurora.org>
Date: Tue, 13 Mar 2018 15:09:00 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested this v2 series on Centriq 2400. Looks good to me.

Reviewed-by: Austin Christ <austinwc@codeaurora.org>

On 3/12/2018 7:14 AM, Abhishek Sahu wrote:
> * v2:
> 
> 1. Address review comments in v1
> 2. Changed the license to SPDX
> 3. Changed commit messages for some of the patch having more detail
> 4. Removed event-based completion and changed transfer completion
>     detection logic in interrupt handler
> 5. Removed dma_threshold and blk_mode_threshold from global structure
> 6. Improved determine mode logic for QUP v2 transfers
> 7. Fixed function comments
> 8. Fixed auto build test WARNING ‘idx' may be used uninitialized
>     in this function
> 9. Renamed tx/rx_buf to tx/rx_cnt
> 
> * v1:
> 
> The current driver is failing in following test case
> 1. Handling of failure cases is not working in long run for BAM
>     mode. It generates error message “bam-dma-engine 7884000.dma: Cannot
>     free busy channel” sometimes.
> 2. Following I2C transfers are failing
>     a. Single transfer with multiple read messages
>     b. Single transfer with multiple read/write message with maximum
>        allowed length per message (65K) in BAM mode
>     c. Single transfer with write greater than 32 bytes in QUP v1 and
>        write greater than 64 bytes in QUP v2 for non-DMA mode.
> 3. No handling is present for Block/FIFO interrupts. Any non-error
>     interrupts are being treated as the transfer completion and then
>     polling is being done for available/free bytes in FIFO.
> 
> To fix all these issues, major code changes are required. This patch
> series fixes all the above issues and makes the driver interrupt based
> instead of polling based. After these changes, all the mentioned test
> cases are working properly.
> 
> The code changes have been tested for QUP v1 (IPQ8064) and QUP
> v2 (IPQ8074) with sample application written over i2c-dev.
> 
> Abhishek Sahu (13):
>    i2c: qup: fix copyrights and update to SPDX identifier
>    i2c: qup: fixed releasing dma without flush operation completion
>    i2c: qup: minor code reorganization for use_dma
>    i2c: qup: remove redundant variables for BAM SG count
>    i2c: qup: schedule EOT and FLUSH tags at the end of transfer
>    i2c: qup: fix the transfer length for BAM RX EOT FLUSH tags
>    i2c: qup: proper error handling for i2c error in BAM mode
>    i2c: qup: use the complete transfer length to choose DMA mode
>    i2c: qup: change completion timeout according to transfer length
>    i2c: qup: fix buffer overflow for multiple msg of maximum xfer len
>    i2c: qup: send NACK for last read sub transfers
>    i2c: qup: reorganization of driver code to remove polling for qup v1
>    i2c: qup: reorganization of driver code to remove polling for qup v2
> 
>   drivers/i2c/busses/i2c-qup.c | 1507 ++++++++++++++++++++++++------------------
>   1 file changed, 880 insertions(+), 627 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
