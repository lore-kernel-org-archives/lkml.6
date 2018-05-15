Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AB8JxZo8A42mMXLAzMCA+/AEnlDtzN7f8bmXqch2fSItw7WcDYXVNDsUOoaZmux/glaE9OJPPJwi
ARC-Seal: i=1; a=rsa-sha256; t=1526409870; cv=none;
        d=google.com; s=arc-20160816;
        b=NO583WlHrHkC2fN8Ts2qSoRTdkl+1HTUp3J0PQVCSfOXhiubc38J9zDL6swZOksenj
         0eLCjO23mT9z7UEYQERw0eiIhdxF6CxqPWtHy0Ubla+nUm++30QNM4zEhae4BLu4RHRk
         dlqFCgw96JaIJC1gPjSGWEpvzoLbKlKgrm8oSb7n9z3rcqYASciqWAGzfPZRf4PiyBg4
         x4YK8/CMwZgq+TU61xl2VltFoNt2mJ/EkTxSIzF2/Fotaum3fUlctuoFFov5K5LRbGsr
         3xczFqdZMVjVU5zawnjD31WvmeGV7ZQdGBfRXU2Z+KwDEqdLrKq0c+1cCT9+nht7OA5I
         YYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=MO+1KhCMdQOsEr04R/XdcMENpfYw0s4uNemd7vbVJDw=;
        b=Dym40vsjaKxm8m54Ajd4hg+nDJB/Ae3jOvXGcwpkeeXcwW7/lsWNXCgY7ZXuDSwRfw
         XD5GUJSrzsb1ryADM9DBEAKQyA1UsiqKMYyqaz69K3veJKS9kGmgGa5LRZAQTCvcfcAH
         y1bwtxx9P/KpE50XeKCCEGz2O4y2z7HPHbtYEU1lXMTo8MsTlk/XeQ+UWBtPQzPte23G
         juFmWLQ4b0Swhn+C5kUVxR8/9oI3Diny35o7dfF088u3uwJcH3yYHNqwuRLkdV/Ej4FO
         zqYCoks8crUjFGEQv3vsc65o950R488bIw40Fwwm5dxEeFF39K/dXyH3gDgnBn7tBR8a
         OzHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1526409864.9159.32.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 014/190] lockd: fix lockd shutdown race
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: "J. Bruce Fields" <bfields@redhat.com>
Cc: stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>, Sasha Levin
 <alexander.levin@microsoft.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  LKML <linux-kernel@vger.kernel.org>
Date: Tue, 15 May 2018 19:44:24 +0100
In-Reply-To: <20180411183550.916927223@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
	 <20180411183550.916927223@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597476067597597006?=
X-GMAIL-MSGID: =?utf-8?q?1600556756231024531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:34 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> 
> [ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]
[...]
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -129,6 +129,8 @@ lockd(void *vrqstp)
>  {
>  	int		err = 0;
>  	struct svc_rqst *rqstp = vrqstp;
> +	struct net *net = &init_net;
> +	struct lockd_net *ln = net_generic(net, lockd_net_id);
>  
>  	/* try_to_freeze() is called from svc_recv() */
>  	set_freezable();
> @@ -173,6 +175,8 @@ lockd(void *vrqstp)
>  	if (nlmsvc_ops)
>  		nlmsvc_invalidate_all();
> 	nlm_shutdown_hosts();
> +	cancel_delayed_work_sync(&ln->grace_period_end);
> +	locks_end_grace(&ln->lockd_manager);
>  	return 0;
>  }
>  
> @@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_se
>  	if (ln->nlmsvc_users) {
>  		if (--ln->nlmsvc_users == 0) {
>  			nlm_shutdown_hosts_net(net);
> -			cancel_delayed_work_sync(&ln->grace_period_end);
> -			locks_end_grace(&ln->lockd_manager);

Aren't these statements still needed for non-initial namespaces?

Ben.

>  			svc_shutdown_net(serv, net);
>  			dprintk("lockd_down_net: per-net data destroyed; net=%p\n", net);
>  		}
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
