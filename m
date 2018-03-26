Return-Path: <christophe.jaillet@wanadoo.fr>
X-Google-Smtp-Source: AG47ELuDo0BPFSgSj1hh3f4Ewi78WUhhbMUVK/ymDV7n0ZsOW6mS+p9FnplhocY9WWq3Apc3RSAL
ARC-Seal: i=1; a=rsa-sha256; t=1522086649; cv=none;
        d=google.com; s=arc-20160816;
        b=ywnsAqQnM02mnngGWvwcfkYi/1pFs0QdRSVVKfzHiaMyK5hAwTgIfJqCAXb0BX7nST
         a2yYPvSSKj784bTs81DRIU3jDisghSjdf3Y30k/FofmVXL//1HPS9xttMlq8YGgav/ob
         wWWIagzMn37PXDl/LyB3Z37OvfELY/m9c6jlx64dJ54Hg67ePUd+Rmpshld/vZECNeGZ
         /3/SYoi36scJzpe0R6WGzBbVXs6YObfFRnhPyhqUh9Lm6KJAAXd2ywe8H6p8GQvCjPfY
         mbAi2VmPRflQLtmLYcMbmwoo1ooULV+NV76XK1K+321l1tEz0IDPFxs38/B5o9vSIyE4
         AHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:newsgroups:cc:to:subject
         :arc-authentication-results;
        bh=7zd36t6WIgtd/DBvkxp+/4Bhho7LUFLEjKwpOJPO3f8=;
        b=1FOojBxBID7h4jKGfzIu7mkXksB31LwehZ37ylywA56qU4b9bxvTtnjFZ5MmoKXMEg
         q//XPjq6VPH5ODoZqjr0sfHkX3YU71L8rHJ7PZCehajl6YfSW+gT4SrHVWR0d8kG9ZBY
         GmsugOqGPg46XPsC+rulw9Tp+6i3Ll00zXRlzfS5mjKysuhtqGFla2xqcuMpQLBReh0D
         npQedL44trEYM10VQgnm/rty1nqG6JOq1J5f+Akhoz/6eKNVEwHxAaRYdA9dqKGZttCV
         EXRiwB016GY6LU1RTmu8LS6Q1RpaVqI73Yy7lxaRUv+spv50EPVJZfKqMupX8mdtwpin
         slew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of christophe.jaillet@wanadoo.fr) smtp.mailfrom=christophe.jaillet@wanadoo.fr
X-ME-Helo: [192.168.0.14]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 26 Mar 2018 19:50:48 +0200
X-ME-IP: 77.198.79.136
Subject: Re: [PATCH] staging: wilc1000: replace kmalloc + memcpy with kmemdup
To: Colin King <colin.king@canonical.com>,
 Aditya Shankar <aditya.shankar@microchip.com>,
 Ganesh Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Newsgroups: gmane.linux.drivers.driver-project.devel,gmane.linux.kernel.wireless.general,gmane.linux.kernel.janitors,gmane.linux.kernel
References: <20180326171629.28700-1-colin.king@canonical.com>
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Message-ID: <c65d1ac5-d5bc-3703-9516-45173a37bac4@wanadoo.fr>
Date: Mon, 26 Mar 2018 19:50:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326171629.28700-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596021371817996393?=
X-GMAIL-MSGID: =?utf-8?q?1596023530163998257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Le 26/03/2018 à 19:16, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
> 
> Replace several allocation and memcpys with kmemdup and add in some
> missing memory allocation failure checks.  Also fix an incorrect
> -EFAULT return with -ENOMEM.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/staging/wilc1000/host_interface.c | 75 +++++++++++++++++++------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
> index 9b9b86654958..8fd367f87fa5 100644
> --- a/drivers/staging/wilc1000/host_interface.c
> +++ b/drivers/staging/wilc1000/host_interface.c
[...]
>   
>   	hif_drv->usr_conn_req.ssid_len = conn_attr->ssid_len;
>   	if (conn_attr->ssid) {
> -		hif_drv->usr_conn_req.ssid = kmalloc(conn_attr->ssid_len + 1,
> +		hif_drv->usr_conn_req.ssid = kmemdup(conn_attr->ssid,
> +						     conn_attr->ssid_len + 1,
>   						     GFP_KERNEL);
>   		if (!hif_drv->usr_conn_req.ssid) {
>   			result = -ENOMEM;
>   			goto error;
>   		}
> -		memcpy(hif_drv->usr_conn_req.ssid,
> -		       conn_attr->ssid,
> -		       conn_attr->ssid_len);
 >               hif_drv->usr_conn_req.ssid[conn_attr->ssid_len] = '\0';

I don't know if it is an issue, but now the memcpy is 1 more byte 
(conn_attr->ssid_len   vs   conn_attr->ssid_len + 1)

kmemdup_nul(conn_attr->ssid, conn_attr->ssid_len, GFP_KERNEL)
and remove hif_drv->usr_conn_req.ssid[conn_attr->ssid_len] = '\0'  ?

CJ

[...]
