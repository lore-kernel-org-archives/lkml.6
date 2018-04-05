Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeDELMQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:12:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:41700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeDELMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:12:15 -0400
Date: Thu, 5 Apr 2018 13:12:12 +0200
From: David Disseldorp <ddiss@suse.de>
To: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
Cc: nab@linux-iscsi.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] target:separate tx/rx cmd_puds
Message-ID: <20180405131212.3f26339d@suse.de>
In-Reply-To: <1521625963-657195-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
References: <1521625963-657195-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The commit summary has a typo (cmd_puds). That said, this change
isn't iSCSI specific, so using "pdu" here doesn't make much sense IMO.

On Wed, 21 Mar 2018 17:52:43 +0800, Zhang Zhuoyu wrote:

> Separate tx/rx cmd_pdus in order to distinguish LUN read/write IOPS.
> 
> Signed-off-by: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
> ---
>  drivers/target/target_core_stat.c      | 26 ++++++++++++++++++++++----
>  drivers/target/target_core_transport.c | 11 ++++++++++-
>  include/target/target_core_base.h      |  3 ++-
>  3 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/target/target_core_stat.c b/drivers/target/target_core_stat.c
> index f0db91e..9099494 100644
> --- a/drivers/target/target_core_stat.c
> +++ b/drivers/target/target_core_stat.c
> @@ -706,7 +722,8 @@ static ssize_t target_stat_tgt_port_hs_in_cmds_show(struct config_item *item,
>  CONFIGFS_ATTR_RO(target_stat_tgt_port_, indx);
>  CONFIGFS_ATTR_RO(target_stat_tgt_port_, name);
>  CONFIGFS_ATTR_RO(target_stat_tgt_port_, port_index);
> -CONFIGFS_ATTR_RO(target_stat_tgt_port_, in_cmds);
> +CONFIGFS_ATTR_RO(target_stat_tgt_port_, tx_cmds);
> +CONFIGFS_ATTR_RO(target_stat_tgt_port_, rx_cmds);

I don't think the in_cmds metric should be deleted here. It could be
calculated on the fly via tx_cmds + rx_cmds + nodata_cmds.

Cheers, David
