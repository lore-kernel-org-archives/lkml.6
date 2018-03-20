Return-Path: <djkurtz@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521568640; cv=none;
        d=google.com; s=arc-20160816;
        b=IaMQumdXm8Lu0tkEhoN/NqTtRx0T2mjxVgS2Y7IFdQwpUaqKA+BZiHBBQnZfe3il3X
         j8EjF5ddNH7+mPWhrEVnq6Yqoj9IbY5ddKpmp5CMrty4TaVTa9m0CWEw9dh1d3zTJi0X
         q+HoHDsYeYpuTjDW1RbpRt+EYgAAtC0U+t0QtSIEyd3QyDAQKYjFNVUJJTWLGWgO/yjZ
         yDorPlbfZ0/1sp8Iv0EI13js03PP+CYK/KPukWgp1JfEA0R0+rAaru3v57rWWMIIqDHT
         g0es8K3Z4bH+bepo35C7EcgH6NHPZcZGmy0ZA33Rbw5PQ1L2uBm3uiaNJN8LVeOPr9BK
         PeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=5QVFavUl1CA0kuadGtkaCMNRiXPJ8ybFmFyIqlm/zWM=;
        b=t5UebSmIsmZko3eS9goqHi5IUqTKjVRjS4IjKtl9lvtuJXRfmqTMoApTjntsWMWPz8
         W7gAcp8oBPw9fUPcSmkc1Kv5ucNOt2Gd8yTnxRVxRI37F2lvzjQa3fNUfgc4CiRzDm1k
         sqImztlosjAPHLUsCgd0RQCMh4H+bW3oPhTkScjkKqiyDEJDxHu1eX7GRNRF60Uq911T
         HqFkLXoS6G1vhbzwVo7XOXoRj9vxSrkPQ61Uxnxes9teNYiqG5nHzqzRtEUl4LxJZNvJ
         QUIdgP+kvQ0agKf/0t3NFzD5ATFOzcYZ1NZKyDoZJmIrPPUa2PRIGeNOMw0j9koSgxps
         5a6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LzOh0bXz;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=LzOh0bXz;
       spf=pass (google.com: domain of djkurtz@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsCQKb+NpPB4+ixK2h3Btjg2XEjSEeHCeDd1dUiqTdfWUvsfA0L/boroi1IOvOwWDzzR7aqow==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: adurbin@chromium.org,
	linux-kernel@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2 0/2] Fix __earlycon_table stride... again
Date: Tue, 20 Mar 2018 11:57:10 -0600
Message-Id: <20180320175712.201572-1-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595480358475048954?=
X-GMAIL-MSGID: =?utf-8?q?1595480358475048954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The __earlycon_table lives in a special "__earlycon_table" section.  The
contents of this table are added using some macros that deposit individual
struct earlycon_id entries into this section.  The linker then defines a symbol
__earlycon_table that is supposed to contain the addresss of the first of these
entries.  The code in earlycon.c and fdt.c then tries to access the memory
pointed to by __earlycon_table as an array of struct earlycon_id entries.

Unfortunately, the compiler doesn't always place the entries such that they
are an array.  Let's fix that.

Patch 1 of the series is a fix that should hopefully fix a kbuild error that
seems to be triggered by Patch 2.

Daniel Kurtz (2):
  serial: sh-sci: Remove __initdata attribute for struct 'port_cfg'
  earlycon: Use a pointer table to fix __earlycon_table stride

 drivers/of/fdt.c                  |  7 +++++--
 drivers/tty/serial/earlycon.c     |  6 ++++--
 drivers/tty/serial/sh-sci.c       |  2 +-
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/serial_core.h       | 21 ++++++++++++++-------
 5 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.16.2.804.g6dcf76e118-goog
