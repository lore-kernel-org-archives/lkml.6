Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbeEDXfV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 19:35:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36091 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEDXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 19:35:19 -0400
X-Google-Smtp-Source: AB8JxZqWt1nrQwpArxtgTuztMR2FSBzUPUQPum5wJINlSbqrqlmW6DRHikFfE8S0d8i9O+TDLZ/Wyw==
Date: Fri, 4 May 2018 16:35:16 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Alex Elder <elder@linaro.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: qmi: fix a buffer sizing bug
Message-ID: <20180504233516.GV18510@minitux>
References: <20180427140817.10871-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427140817.10871-1-elder@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Apr 07:08 PDT 2018, Alex Elder wrote:

> In qmi_handle_init(), a buffer is allocated for to hold messages
> received through the handle's socket.  Any "normal" messages
> (expected by the caller) will have a header prepended, so the
> buffer size is adjusted to accomodate that.
> 
> The buffer must also be of sufficient size to receive control
> messages, so the size is increased if necessary to ensure these
> will fit.
> 
> Unfortunately the calculation is done wrong, making it possible
> for the calculated buffer size to be too small to hold a "normal"
> message.  Specifically, if:
> 
>   recv_buf_size > sizeof(struct qrtr_ctrl_pkt) - sizeof(struct qmi_header)
> 		AND
>   recv_buf_size < sizeof(struct qrtr_ctrl_pkt)
> 
> the current logic will use sizeof(struct qrtr_ctrl_pkt) as the
> receive buffer size, which is not enough to hold the maximum
> "normal" message plus its header.  Currently this problem occurs
> for (13 < recv_buf_size < 20).
> 
> This patch corrects this.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>

Good catch, thanks!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/qmi_interface.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
> index 321982277697..938ca41c56cd 100644
> --- a/drivers/soc/qcom/qmi_interface.c
> +++ b/drivers/soc/qcom/qmi_interface.c
> @@ -639,10 +639,11 @@ int qmi_handle_init(struct qmi_handle *qmi, size_t recv_buf_size,
>  	if (ops)
>  		qmi->ops = *ops;
>  
> +	/* Make room for the header */
> +	recv_buf_size += sizeof(struct qmi_header);
> +	/* Must also be sufficient to hold a control packet */
>  	if (recv_buf_size < sizeof(struct qrtr_ctrl_pkt))
>  		recv_buf_size = sizeof(struct qrtr_ctrl_pkt);
> -	else
> -		recv_buf_size += sizeof(struct qmi_header);
>  
>  	qmi->recv_buf_size = recv_buf_size;
>  	qmi->recv_buf = kzalloc(recv_buf_size, GFP_KERNEL);
> -- 
> 2.14.1
> 
