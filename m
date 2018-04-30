Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755098AbeD3Qrh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:47:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38166 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753334AbeD3Qrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:47:35 -0400
Subject: Re: [PATCH] ethtool: fix a potential missing-check bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Edward Cree <ecree@solarflare.com>, Inbar Karmy <inbark@mellanox.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Vidya Sagar Ravipati <vidya.chowdary@gmail.com>,
        Alan Brady <alan.brady@intel.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525051915-31944-1-git-send-email-wang6495@umn.edu>
From: Shannon Nelson <shannon.nelson@oracle.com>
Organization: Oracle Corporation
Message-ID: <1546193f-ed07-9a10-d2b3-d1d28138e291@oracle.com>
Date: Mon, 30 Apr 2018 09:46:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525051915-31944-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2018 6:31 PM, Wenwen Wang wrote:
> In ethtool_get_rxnfc(), the object "info" is firstly copied from
> user-space. If the FLOW_RSS flag is set in the member field flow_type of
> "info" (and cmd is ETHTOOL_GRXFH), info needs to be copied again from
> user-space because FLOW_RSS is newer and has new definition, as mentioned
> in the comment. However, given that the user data resides in user-space, a
> malicious user can race to change the data after the first copy. By doing
> so, the user can inject inconsistent data. For example, in the second
> copy, the FLOW_RSS flag could be cleared in the field flow_type of "info".
> In the following execution, "info" will be used in the function
> ops->get_rxnfc(). Such inconsistent data can potentially lead to unexpected
> information leakage since ops->get_rxnfc() will prepare various types of
> data according to flow_type, and the prepared data will be eventually
> copied to user-space. This inconsistent data may also cause undefined
> behaviors based on how ops->get_rxnfc() is implemented.
> 
> This patch re-verifies the flow_type field of "info" after the second copy.
> If the value is not as expected, an error code will be returned.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>   net/core/ethtool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/ethtool.c b/net/core/ethtool.c
> index 03416e6..a121034 100644
> --- a/net/core/ethtool.c
> +++ b/net/core/ethtool.c
> @@ -1032,6 +1032,8 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
>   		info_size = sizeof(info);
>   		if (copy_from_user(&info, useraddr, info_size))
>   			return -EFAULT;

You might add a comment here to explain why the second check; otherwise 
someone might come along later and remove this check as redundant code.

sln

> +		if (!(info.flow_type & FLOW_RSS))
> +			return -EINVAL;
>   	}
>   
>   	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
> 
