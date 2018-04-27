Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AB8JxZrTwOdSNThJlVCGXTYaa/r/1hin1L5BGuEMzJ1BFmc9Om8clTc5lK9Q58naB6VEG+JE86F0
ARC-Seal: i=1; a=rsa-sha256; t=1524840987; cv=none;
        d=google.com; s=arc-20160816;
        b=Mkn6g7dMeV1KE2GNVNscHo2VFXC9buRxHcDTJAnMGMw2BaBfFbuVgF0qVFJFxI/vBg
         IDCJ3TJnSdX4g1cWuzGbWge+aACdHTtRONayftzw/rGKZpnkhRrsE8oqZS5xZhNHO2To
         by8QtoRyDnvW8jbAJgeIp5WAbyA9fjO7YteDC9qNRzlcPJjnzp53c308IcOkYrMfKPAE
         KDNHyFSYn5aJMiTGsQahbT/F9HhnIqztWGPVaHpU8OjKnF9JYRjUrQnHWN5N3igW2lNo
         ZKKUscG3OQ2I0achBEndh37862dWfiA1FN1SXNtvk2tfAJLWcZrajfOcOkpwa2B3cKmg
         YABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=e8uRL9cRG1PeG5NsOUd+MKj9MqdCqMoQkoD2JWZ+Cao=;
        b=NJYSgVsuP7ZLhYyXbSzwXJjO2p2iqjAq5zWQN8cKB8txxD2iBpf3ge8ejq6Cag2k/Y
         WEzm1swycR4ZZ6iqJwCMLzgymLnTMneMkV3g+IW60/mrmHcMF2vik2MakkJlsTludmgm
         SoVGJZt6BpnAvYLkT508DZdEuUCaKqhgn14o1xtPkdKU71Sn/+zSTkUE2GUwDuUrlAIf
         RDDkHulIpje40IV04hEAOn72WD7jkzvCW0+IStivYJCC2KYEm1x5NonurmYO2GOWRdNO
         V7dU4943cq/kFuUbKvRcwVDt2z6Ppaeo32NqwBu7kwll83IMeefDW4PHam86IvC8ARGn
         3Uhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Fri, 27 Apr 2018 16:56:23 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory_hotplug: use put_device() if device_register
 fail
Message-ID: <20180427145623.GC5404@dhcp22.suse.cz>
References: <2987b5bdb31e7c18cd837da0f1e32a98fecd3278.1524757165.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2987b5bdb31e7c18cd837da0f1e32a98fecd3278.1524757165.git.arvind.yadav.cs@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823954747248901?=
X-GMAIL-MSGID: =?utf-8?q?1598911663397378638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 26-04-18 21:12:09, Arvind Yadav wrote:
> if device_register() returned an error. Always use put_device()
> to give up the initialized reference and release allocated memory.

Is this patch correct? The docummentation says
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up your
 * reference instead.

but we do not have _our_ reference in this path AFAICS. Maybe this is
just a documentation issue? How have you tested this change btw.?

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/base/memory.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index bffe861..f5e5601 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -649,13 +649,19 @@ static const struct attribute_group *memory_memblk_attr_groups[] = {
>  static
>  int register_memory(struct memory_block *memory)
>  {
> +	int ret;
> +
>  	memory->dev.bus = &memory_subsys;
>  	memory->dev.id = memory->start_section_nr / sections_per_block;
>  	memory->dev.release = memory_block_release;
>  	memory->dev.groups = memory_memblk_attr_groups;
>  	memory->dev.offline = memory->state == MEM_OFFLINE;
>  
> -	return device_register(&memory->dev);
> +	ret = device_register(&memory->dev);
> +	if (ret)
> +		put_device(&memory->dev);
> +
> +	return ret;
>  }
>  
>  static int init_memory_block(struct memory_block **memory,
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
