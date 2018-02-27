Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeB0Wg7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:36:59 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53507 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeB0Wg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:36:56 -0500
X-Google-Smtp-Source: AG47ELuH9PInCoA2xs9TP5Q+y68IsxFO2qk0edcH+kspJCUgH/KVkmpCw30ux/YhD2iAoaJJIxpWvQ==
Date: Tue, 27 Feb 2018 16:36:54 -0600
From: Andy Gross <andy.gross@linaro.org>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] i2c: qup: schedule EOT and FLUSH tags at the end
 of transfer
Message-ID: <20180227223654.GE20901@hector.attlocal.net>
References: <1517644697-30806-1-git-send-email-absahu@codeaurora.org>
 <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517644697-30806-5-git-send-email-absahu@codeaurora.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 01:28:09PM +0530, Abhishek Sahu wrote:
> A single BAM transfer can have multiple read and write messages.
> The EOT and FLUSH tags should be scheduled at the end of BAM HW
> descriptors. Since the READ and WRITE can be present in any order
> so for some of the cases, these tags are not being written
> correctly.
> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 54 ++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index bb83a2967..6357aff 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -560,7 +560,7 @@ static int qup_i2c_set_tags_smb(u16 addr, u8 *tags, struct qup_i2c_dev *qup,
>  }
>  
>  static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
> -			    struct i2c_msg *msg,  int is_dma)
> +			    struct i2c_msg *msg)
>  {
>  	u16 addr = i2c_8bit_addr_from_msg(msg);
>  	int len = 0;
> @@ -601,11 +601,6 @@ static int qup_i2c_set_tags(u8 *tags, struct qup_i2c_dev *qup,
>  	else
>  		tags[len++] = data_len;
>  
> -	if ((msg->flags & I2C_M_RD) && last && is_dma) {
> -		tags[len++] = QUP_BAM_INPUT_EOT;
> -		tags[len++] = QUP_BAM_FLUSH_STOP;
> -	}
> -

So lets say you have multiple read and 1 write message.  These changes will send
a EOT/FLUSH for all reads.  I think the intent here was that the last read
message (not the last message) would have the EOT+FLUSH.  Can there be an issue
with sending EOT/FLUSH for all reads?  And how does this mesh up with the BAM
signaling?


Regards,

Andy
