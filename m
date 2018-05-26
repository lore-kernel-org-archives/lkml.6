Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeEZESo (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 00:18:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34913 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeEZESm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 00:18:42 -0400
X-Google-Smtp-Source: AB8JxZp5TsjhcOTvstkTha/ORoNZE1M+wW5jvCkGv66Q+qknKbvKkj/g2i1VC7h7HLj4+wIxPsVD+A==
Date: Fri, 25 May 2018 21:20:20 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qcom: cmd-db: enforce CONFIG_OF_RESERVED_MEM dependency
Message-ID: <20180526042020.GA2259@tuxbook-pro>
References: <20180525160836.125531-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525160836.125531-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25 May 09:08 PDT 2018, Arnd Bergmann wrote:

> Without CONFIG_OF_RESERVED_MEM, gcc sees that the global cmd_db_header
> variable is never initialized, and through code optimization concludes
> that a lot of other code cannot possibly work after that:
> 
> drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_addr':
> drivers/soc/qcom/cmd-db.c:197:21: error: 'ent.addr' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   return ret < 0 ? 0 : le32_to_cpu(ent.addr);
> drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_aux_data':
> drivers/soc/qcom/cmd-db.c:224:10: error: 'ent.len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   ent_len = le16_to_cpu(ent.len);
> drivers/soc/qcom/cmd-db.c:115:6: error: 'rsc_hdr.data_offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   u16 offset = le16_to_cpu(hdr->data_offset);
>       ^~~~~~
> drivers/soc/qcom/cmd-db.c:116:6: error: 'ent.offset' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   u16 loffset = le16_to_cpu(ent->offset);
>       ^~~~~~~
> drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_aux_data_len':
> drivers/soc/qcom/cmd-db.c:250:38: error: 'ent.len' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   return ret < 0 ? 0 : le16_to_cpu(ent.len);
>                                       ^
> drivers/soc/qcom/cmd-db.c: In function 'cmd_db_read_slave_id':
> drivers/soc/qcom/cmd-db.c:272:7: error: 'ent.addr' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> Using a hard CONFIG_OF_RESERVED_MEM dependency avoids this warning,
> and we can remove the CONFIG_OF dependency.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 9dc02f390ba3..5856e792d09c 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -5,7 +5,8 @@ menu "Qualcomm SoC drivers"
>  
>  config QCOM_COMMAND_DB
>  	bool "Qualcomm Command DB"
> -	depends on (ARCH_QCOM && OF) || COMPILE_TEST
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF_RESERVED_MEM
>  	help
>  	  Command DB queries shared memory by key string for shared system
>  	  resources. Platform drivers that require to set state of a shared
> -- 
> 2.9.0
> 
