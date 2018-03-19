Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDUJxBzeJFl8zif3MTyGiNhVhDIWw3I241g4sjHHACQO0tNY9wzyrMenzsTPisu/xQJAAF
ARC-Seal: i=1; a=rsa-sha256; t=1521483196; cv=none;
        d=google.com; s=arc-20160816;
        b=Vfzve0iGGGD7r8SCK4Zs4siDMtnu9/FfOEK4BzjTQRzVEg0eaUcdc1A67ENhTu/ULw
         Y32GD/KL9OB44Hh4vfEmsyHI6kj9fVUs3jcL+09UDkcLI7G7tZyqRDF0dckf0+ee5wjT
         96SY9/F6pAZG0gLY3mhifgRSCdxe7iB9NdmHVAAwGjUx/QjJyye2kZNoLCt5J5A1DGhv
         bt8gZR38xOJkoG64qOUHzVAQEekG6cvBvej8ivarV8rRgw0UWM5owWdzLF5Nns3SLXM0
         YXU87Y0ZKUnd4e0MLiOrrHTDxmE3O7sQ1J9NlHk80G7YLs/edVEhGUQP2Xg3Cau2SJQU
         f+GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bRN7aDpzyLD1+MmCvmgLDWKsniBjzCq0d/Xm4QBm+Ug=;
        b=o/kNsdAfcyVoA9UorWcw82sm8xb7VBv+KiKqbFRV+aMiMYJnTdxGt7hPzelmIhrjqv
         PIZss74JMhIxcBohThM4DRvZzunWmJd9oho3Ks/8bviObpeSTjjJyR4BbWktDEn/vJ95
         EWQmD0n4EAp9IoM5JEwv8NHQmP2NXGp1ucrJdsCQ2yrLvvKFINVZLspe4W66hkwKhg53
         WvM4utXBbSaMhR7YU0Sbb/TjqKfWbB9t0e+ld3j7ocg3wQvGREgfP211gbC8fsEmxyi7
         4cSYN8tuRQzJiYwvMk63EKy5a5+TS+2gRRREEWDmAdFVDDkNYfJp72PgZHupISq7e8qz
         Y9GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gao Feng <fgao@ikuai8.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 033/134] tcp: sysctl: Fix a race to avoid unexpected 0 window from space
Date: Mon, 19 Mar 2018 19:05:16 +0100
Message-Id: <20180319171854.104088447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390523266264934?=
X-GMAIL-MSGID: =?utf-8?q?1595390763705180077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Feng <fgao@ikuai8.com>


[ Upstream commit c48367427a39ea0b85c7cf018fe4256627abfd9e ]

Because sysctl_tcp_adv_win_scale could be changed any time, so there
is one race in tcp_win_from_space.
For example,
1.sysctl_tcp_adv_win_scale<=0 (sysctl_tcp_adv_win_scale is negative now)
2.space>>(-sysctl_tcp_adv_win_scale) (sysctl_tcp_adv_win_scale is postive now)

As a result, tcp_win_from_space returns 0. It is unexpected.

Certainly if the compiler put the sysctl_tcp_adv_win_scale into one
register firstly, then use the register directly, it would be ok.
But we could not depend on the compiler behavior.

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/tcp.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1199,9 +1199,11 @@ void tcp_select_initial_window(int __spa
 
 static inline int tcp_win_from_space(int space)
 {
-	return sysctl_tcp_adv_win_scale<=0 ?
-		(space>>(-sysctl_tcp_adv_win_scale)) :
-		space - (space>>sysctl_tcp_adv_win_scale);
+	int tcp_adv_win_scale = sysctl_tcp_adv_win_scale;
+
+	return tcp_adv_win_scale <= 0 ?
+		(space>>(-tcp_adv_win_scale)) :
+		space - (space>>tcp_adv_win_scale);
 }
 
 /* Note: caller must be prepared to deal with negative returns */
