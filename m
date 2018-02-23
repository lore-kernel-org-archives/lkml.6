Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv2+2nwac8NTpWjNdUJHQI90KBBaU85Nxb4x+yejzgb5Zhto1cS0sbXI3avKESPIvWmK5Ra
ARC-Seal: i=1; a=rsa-sha256; t=1519412131; cv=none;
        d=google.com; s=arc-20160816;
        b=zIsF2/C1e0iFLtCoz+gHzZMsqn0wCdOj/MfL/U0L2NgStNlSzfNo+yYiXr0YJDh0Od
         MtdYcfDjqQb4UeF/kDNVwZSttiiwG9Lpxz169oTkKiVofkr5OkauCLFy3iXr4dbK4S3K
         Cos9WAwMAfvLZ0I+PrM0s5rH9pqBVnXrUkSWAQRnrQ48Wvz7gpuay8MR5HTrcLAotzzW
         1ThW5QHnmJ4h0bTT+UVl0vKVn+an6XSJKbzMgqcrl1SOXFvCGMri8k3GwPh03mUaA/Ek
         EVHepF9342Ompnf54QzMa+nAOQHiGDQFMN56KFy6Mm4LcYdbsFqO6DRBgQ8ol7ueJCxP
         ZFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sgzdm76EbC8I/29jncHFLOu/xzQh+W97BRwoTrP3myo=;
        b=0eaT1X9Y1GnVXAhsdlyQvPYm/yxEli9GApdnsajKtnrP+PxyXqGPeU2AXNJAZMRJ7z
         /CdmGckC/ncAL1x2T03VXoHTymHaXEYlmoAtwbwyLoSUliF017Uiuf43kVv6FdVWAyyg
         z6E74NSEKg/1U9anmh1/xTHHIVTdJ2SYiyOl2iupzJqtreft8WLOX+DcLkG/8q/Q3x1N
         r99fw0W0G/eYhc+A9JXBEgWNz6W6IN3NYrqWbJCBG6Zb1TlsTOPkhY9h2xwYV9Jy79OT
         N5307pkVgO5wVx+AW7pq2yE51a15ogEGOFJi112abS7BbL/ncnPpLGHTUrALQU1VY+ly
         LfYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Cai Li <cai.li@spreadtrum.com>,
	Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 135/159] clk: fix a panic error caused by accessing NULL pointer
Date: Fri, 23 Feb 2018 19:27:23 +0100
Message-Id: <20180223170759.422992720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217801822508203?=
X-GMAIL-MSGID: =?utf-8?q?1593219094766001543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cai Li <cai.li@spreadtrum.com>


[ Upstream commit 975b820b6836b6b6c42fb84cd2e772e2b41bca67 ]

In some cases the clock parent would be set NULL when doing re-parent,
it will cause a NULL pointer accessing if clk_set trace event is
enabled.

This patch sets the parent as "none" if the input parameter is NULL.

Fixes: dfc202ead312 (clk: Add tracepoints for hardware operations)
Signed-off-by: Cai Li <cai.li@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/clk.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/trace/events/clk.h
+++ b/include/trace/events/clk.h
@@ -134,12 +134,12 @@ DECLARE_EVENT_CLASS(clk_parent,
 
 	TP_STRUCT__entry(
 		__string(        name,           core->name                )
-		__string(        pname,          parent->name              )
+		__string(        pname, parent ? parent->name : "none"     )
 	),
 
 	TP_fast_assign(
 		__assign_str(name, core->name);
-		__assign_str(pname, parent->name);
+		__assign_str(pname, parent ? parent->name : "none");
 	),
 
 	TP_printk("%s %s", __get_str(name), __get_str(pname))
