Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEMHCN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 03:02:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32895 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeEMHCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 03:02:08 -0400
X-Google-Smtp-Source: AB8JxZr/Ec6JT9RjulA2REI/+ffhLxcIwQMirDiQkZKAD2i3g/yR61nbGXW+01h/FmVeXSbkW/q2pg==
Subject: Re: [PATCH] net/mlx4_core: Fix error handling in mlx4_init_port_info.
To: Tarick Bedeir <tarick@google.com>, gthelen@google.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180427152015.185861-1-tarick@google.com>
 <7e5d6d30-ed89-8a8e-55c1-a25897937727@mellanox.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
Message-ID: <85680666-cf07-2d88-328a-d676d71a403a@gmail.com>
Date: Sun, 13 May 2018 10:02:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7e5d6d30-ed89-8a8e-55c1-a25897937727@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/05/2018 4:31 PM, Tariq Toukan wrote:
> 
> 
> On 27/04/2018 6:20 PM, Tarick Bedeir wrote:
>> Avoid exiting the function with a lingering sysfs file (if the first
>> call to device_create_file() fails while the second succeeds), and avoid
>> calling devlink_port_unregister() twice.
>>
>> In other words, either mlx4_init_port_info() succeeds and returns 
>> zero, or
>> it fails, returns non-zero, and requires no cleanup.
>>
>> Signed-off-by: Tarick Bedeir <tarick@google.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx4/main.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c 
>> b/drivers/net/ethernet/mellanox/mlx4/main.c
>> index 4d84cab77105..e8a3a45d0b53 100644
>> --- a/drivers/net/ethernet/mellanox/mlx4/main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx4/main.c
>> @@ -3007,6 +3007,7 @@ static int mlx4_init_port_info(struct mlx4_dev 
>> *dev, int port)
>>           mlx4_err(dev, "Failed to create file for port %d\n", port);
>>           devlink_port_unregister(&info->devlink_port);
>>           info->port = -1;
>> +        return err;
>>       }
>>       sprintf(info->dev_mtu_name, "mlx4_port%d_mtu", port);
>> @@ -3028,9 +3029,10 @@ static int mlx4_init_port_info(struct mlx4_dev 
>> *dev, int port)
>>                      &info->port_attr);
>>           devlink_port_unregister(&info->devlink_port);
>>           info->port = -1;
>> +        return err;
>>       }
>> -    return err;
>> +    return 0;
>>   }
>>   static void mlx4_cleanup_port_info(struct mlx4_port_info *info)
>>
> Acked-by: Tariq Toukan <tariqt@mellanox.com>
> 
> Thanks Tarick.

Actually, you need to add a Fixes line:

Fixes: 096335b3f983 ("mlx4_core: Allow dynamic MTU configuration for IB 
ports")
