Return-Path: <kernel-hardening-return-11988-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsIocmU/cHisBh7KDzte3oQKxOr1DCNMNN5ln64AY9f7fTYUR4aYvk+I1l/vNfjeuy0x7Ui
ARC-Seal: i=1; a=rsa-sha256; t=1519706741; cv=none;
        d=google.com; s=arc-20160816;
        b=y7jRef84b/gbcG4ZDU9TR0RbEU3VLLA1v/OuArdd8WMNKccmFzNQ6VhHP38tumOFv1
         xjwg+mpQ9Y2MrKNb71BwwP89D87ECdd6fSQVuSHSWYFXADHworoaMIH3T7zewyziFXtZ
         NjUB1sebs3zMaAI/B+XCKSl9CFdfRiI19OcDrc8gZaUMqWlh4CoYV/+uFF6VJ4oie0ss
         FY0iTnds3MsyjompUWk7S6eAGMsycTO+gF3FXloL+js496UN+7n6M0VMlqwe0VM8I5r1
         B0FmTKKdF/gQEu66SCPKcJaRkMJCeFnV8n+sFjYKufKSyc1lOW0MEH/zTcIDKsdObSVo
         eqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=u2Gtcu23naRnxJ+oRvX9q5zpsLNEyQMhey/bxaEzU4M=;
        b=PZVsj9RFM9Y30r8wI8UIEY1xhwZCsiw0CWiSm5x9uisxQ372Z9lUrIgOiZd+A2jJSQ
         vIpvI8bt/EbuQ+6HEIq489sGLvPBSU9WVXtPnFkyfqAsZ5muLyi9PiX9xyUQWphlUbSu
         8hs0jgMVfVbKamshK8qBzDcF+rDCCc0VIkxxX6VF5OQgBIwfNvk7/pABu6Wwz+Yi6nKp
         3EneXhZWaxl5p9jTvnKvx7+D+zOWJ7lvtB0ddIKr/IoIirK/LNILb2funC19zgjvzzzv
         +wX+vQoNKcuV6Ng7OyDRQvF/NeaF0Vg2Lu3VcUNx4ZCqfxGvVYkJYuwqijK0q1m66HjW
         vlNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=g/G+QXtQ;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=GjKneD3T;
       spf=pass (google.com: domain of kernel-hardening-return-11988-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11988-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=g/G+QXtQ;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=GjKneD3T;
       spf=pass (google.com: domain of kernel-hardening-return-11988-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11988-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:YuKUWv4GMUGY58or8yRs8_Qw7969yqemOT8eZ2tZzeXvkj0kUn8CUA>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] leaking_addresses: limit scan to PID==1
Date: Tue, 27 Feb 2018 15:45:08 +1100
Message-Id: <1519706711-18580-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528016166865311?=
X-GMAIL-MSGID: =?utf-8?q?1593528016166865311?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This set implements improvements discussed offline with Tycho as well as
from suggestions on LKML.

We no longer bother to scan /proc/PID for every PID on the system.
Instead we only scan /proc/1 (still scan other non-pid related
files/directoies).  The reasoning is given in the commit log of patch 1,
duplicated here for reference:

	When the system is idle it is likely that most files under
	/proc/PID will be identical for various processes.  Scanning
	_all_ the PIDs under /proc is unnecessary and implies that we
	are thoroughly scanning /proc. This is _not_ the case because
	there may be ways userspace can trigger creation of /proc files
	that leak addresses but were not present during a scan.  For
	these two reasons we should exclude all PID directories under
	/proc except '1/' 
    
Next, we skip parsing /proc/1/syscall as suggested because the pointers
listed are user pointers, and negative syscall args will show up like
kernel pointers.

Finally we remove version number from the script.

This set represents the tip of the branch 'leaks-testing' available at

	git://git.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git


thanks,
Tobin.


Tobin C. Harding (3):
  leaking_addresses: skip all /proc/PID except /proc/1
  leaking_addresses: skip '/proc/1/syscall'
  leaking_addresses: remove version number

 scripts/leaking_addresses.pl | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.7.4
