Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx4/F8GnrL3dC/MQELXYwhnQSDSFoL2fUx/YtW96tkj3nb7wsZ2mGDPPQmGV32fuvQl8kQ7xa
ARC-Seal: i=1; a=rsa-sha256; t=1523546074; cv=none;
        d=google.com; s=arc-20160816;
        b=tn2bg3zD02z5R6tHZi46V48nXx8LgkblPff9jIQG0qohoX3SGamxlsFm9YMZcCFQYK
         U8SPlw1L1Y16u9ss7L7vi7mBn9eHGFWQsWAbEk8Q3TVKADX/9kxR4cnbYjXNURT+uLCE
         QSFpXDLcGO2GSUN+zXvCQJlkaOrDX4QH12faHpVN7cedXoDbH8v8j6VUjJSy/MiRL7zv
         D9ZqjPHTJCsdN2InA/lDnCYHZQSrF7ka44PUA3WTsVmX0cXU+ClkMNMp+U1+6Mhhrucj
         wNkAVE0IW61SOmF4iwrTxtUX1uDJipgScsxmYrgswzglkoCksguHZdKjJDYNMqc3OoeY
         7jGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=rTbdvvU3KbghKjTO+gfVIFOWNde80yVXgtKOwnNivS8=;
        b=YKzzIsX/g1GZXK6NQ2skyyN9J9Acg25+f9Kpc3y2grY/TfIVNhH/bziUw4lxYXdkdj
         xUwTZeR/SH4RDBGuNys6qZKpZpCJgCYVdcICBDeULkZCC7LkI/6OYpFoxa9tg0+sHeE8
         sbn/l4X9ZJ5vWnNvguv7LpNuC96Y+WyWB+WmzgeV4So8zm/eLJ3mlgMXfSZ0FFUExx5/
         uSQsG+YEpgLEYy45jFLbGdjtI+qnmnus8rg/gU7pYD+Lj0e/ohU6PI/jYUACcBcQt9FL
         Gip5wYSZr3nk1RVzOJrdi2pNAS5OejCJNux/26xCGe7dMIxZv+nlbj0tN0Rrmkmlt/kW
         VLSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.51.209 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.51.209 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Subject: Re: [PATCH] staging: ks7010_sdio: fix NULL pointer dereference and
 memory leak
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Colin King <colin.king@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180412143009.GA31998@embeddedor.com>
 <20180412150825.ckyvcmw2shvdbwvs@mwanda>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <466bc78a-8cc5-a693-278b-da34194a35b2@embeddedor.com>
Date: Thu, 12 Apr 2018 10:14:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412150825.ckyvcmw2shvdbwvs@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f6dvj-001UDh-V8
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.145.54.187]:48172
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597551056271378214?=
X-GMAIL-MSGID: =?utf-8?q?1597553848234003930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On 04/12/2018 10:08 AM, Dan Carpenter wrote:
> I added Colin to the Cc list.
> 
> On Thu, Apr 12, 2018 at 09:30:09AM -0500, Gustavo A. R. Silva wrote:
>> priv is being dereferenced when it is still null, hence there is an
>> explicit null pointer dereference at line 935: free_netdev(priv->net_dev)
>>
>> Also, memory allocated for netdev at line 854:
>> netdev = alloc_etherdev(sizeof(*priv));
>> is not being free'd, hence there is a memory leak.
>>
>> Fix this by null checking priv before dererefencing it and free netdev
>> before return.
>>
>> Addresses-Coverity-ID: 1467844 ("Explicit null dereferenced")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/staging/ks7010/ks7010_sdio.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
>> index b8f55a1..f5d4c62 100644
>> --- a/drivers/staging/ks7010/ks7010_sdio.c
>> +++ b/drivers/staging/ks7010/ks7010_sdio.c
>> @@ -932,8 +932,12 @@ static int ks7010_sdio_probe(struct sdio_func *func,
>>   	return 0;
>>   
>>    err_free_netdev:
>> -	free_netdev(priv->net_dev);
>> -	card->priv = NULL;
>> +	if (priv) {
>> +		free_netdev(priv->net_dev);
>> +		card->priv = NULL;
> 
> This isn't required because the next thing we do to card is kfree(card).
> 

I got it.

>> +	} else {
>> +		free_netdev(netdev);
>> +	}
> 
> 
> That's too complicated.  Just do:
> 
> err_free_netdev:
> 	free_netdev(net_dev);
> 
> err_release_irq:
> 	...
> 
> Please send a v2 patch.
> 

Sure thing, I'll send it shortly.

Thanks for the feedback.
--
Gustavo
