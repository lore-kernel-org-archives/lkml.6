Return-Path: <bp@alien8.de>
X-Google-Smtp-Source: AG47ELvc0WmZNVnVcCNpjBSiHPDAjJxnjmN5HvZynhgiIUtx4Z0P3QUS6+UZX53vWwPMne+UtN/g
ARC-Seal: i=1; a=rsa-sha256; t=1519810383; cv=none;
        d=google.com; s=arc-20160816;
        b=qBB5nLM1OTVol1Y1UGUSkkDMZrB/Qrx+qpDhFuhmvXu/xhLv0HJbU9B5U5i1Gnjdnm
         HD/xDIY+RT4PfvehC5T8mF3u6YJyAgNc8NpKjHVf+d+7IuzfjL5Vlc1urKBg3azynHIo
         ss4/ctf8bFXwaDzh853UYZzPJS/RuIlfdazYUEBvBuwE2k2/tw6tPmbyuyJi2SZiFWSf
         bul9nkQ59mvJsI1UEgqJ3ZD5f8mtcj0e/IqXQQP9i8A2SN2wEySAy+xC4QS2E1XWHwYn
         21nqA80xmAdiQkaFpDapNyMmSmHeXSBdlH6mW/C9oS4L74dkmwXrFW48ByojLf509LO8
         RYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=r8h4oS080znn/D1auPaf6J6Lt6XKhtODGUzmuelgBFQ=;
        b=i7CWlnhMC47cXe6E2oTsyXQEgL7oaB4Q/u47WTeZghmx0KpM67nRqA8uRkFlMfwxbY
         7ESDB3j5R/M3i33ZSfY0GjjR1IuFicfUM6luoTGrW2Jp7mOwfsZB9P6+v1Sp1hVYdPSu
         23rksKS6+o2chhxOvEGQV6JNauCPYwVa5vWP0qlNcKLezCyna+d2/WclCN0FGgIdb1CB
         0a9yVRBEHYbU4r4/NFWePqEiMpMQ426bV3aWgdPohwhjPhwZKK63N1StzR6PHYsvR7ad
         nPvPAwIAkiR0WA/2/H/BmwiPB1CD0M1ItnEDsCawrj3tme1hbU7Ox+O0XqnxbmvldiT/
         XYHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@alien8.de designates 2a01:4f8:190:11c2::b:1457 as permitted sender) smtp.mailfrom=bp@alien8.de
Date: Wed, 28 Feb 2018 10:32:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Seunghun Han <kkamagui@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: mce: fix kernel panic when check_interval is changed
Message-ID: <20180228093238.GA3769@pd.tnic>
References: <20180223101350.8344-1-kkamagui@gmail.com>
 <20180223105220.GA12058@kroah.com>
 <CAHjaAcTVUxm6LnD_3sp2BwGgR9ustuctoHUBFkMD1nZh4o6bTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHjaAcTVUxm6LnD_3sp2BwGgR9ustuctoHUBFkMD1nZh4o6bTA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186374882748310?=
X-GMAIL-MSGID: =?utf-8?q?1593636692197214243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 05:05:04AM +0900, Seunghun Han wrote:
> >> It is a critical security problem because the attacker can make kernel panic
> >> by writing a value to the check_interval file in userspace, and it can be
> >> used for Denial-of-Service (DoS) attack.
> >
> > As only root can write to that file, it's not that critical of an issue,
> > but yes, this is a problem.  Nice find and fix.

This is still the wrong fix. You need to:

1. check the old value of check_interval in store_int_with_restart() and
exit early if it is the same.

2. have mce_restart() grab a newly defined mutex, say, mce_sysfs_mutex
or so, which synchronizes all CPUs so that their timers get deleted and
reinitialized in the proper order.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
