Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDxy1Wv9JHZQgsP/X20V7Z9GF0fJq/csxpnKVo5ptzUghdubXVJqi+DRflwnnGTYQisSqa
ARC-Seal: i=1; a=rsa-sha256; t=1525116539; cv=none;
        d=google.com; s=arc-20160816;
        b=ZgFU1HB7PD7/rCiXdAL0qV/Y+o24MYYSZ4vt9+A/I9Kx6QA1WD/J5kvRAxntMLHnGn
         StTRtGHTj+XCZIEA8j+rqBAXmZEqojybG6UbZ42o633x9hzmrS0nh+sLdarLYzRmjeEM
         wtK3JIHkH0HplA+T9pYQF7SxZuuu/P0CrEiDhI3cFx9jIT0Q1Od6qrQsllhv6T8Dv+ro
         TJVSq3xcaOfTtvnAodm8juqgFSxGAxbeTmGeakrjzjX+7EsUTb/K2KdWZvpSV0dxuyL9
         IR77xuY+xPRmaEb2UZ/aHFj0MMXsis9Hxi0UIKuBAeMSDoIllxXRX1ozdAyOHkuZGmfw
         chaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=jBvzrorcW81Se9aA7HdvC7IpqiqUKZ63HH2NC/5sH0c=;
        b=mibp4SE52smhzWtVEfIXoZ9S1vbI2N7+3lBIK5d8SPK32MHBnx/62rGQvaJFhxRUnk
         d5Yd8oUfZUqrs0M/mLe/ZT/IAiNHgeFo5GXrtTHKCfGmyq0tFUOJ3qXhMO9rMytBr3AI
         HOHgOjQQtyl+nok6pTNqUBXKyxRQCex2lG1+J+qKr+Ev485zOc+LuBdpuSGnrd576inD
         pvfbBoESFxX0Ng4iDXGS2xEPRw74n25xGE9cSNPEiSsRUFuyGd09FEfr8G7xh8V2BHP9
         GLSVsogSz/cdqsYZyVj4zefUSb2aSbJvYSdPFWAxwi37X57DYzTF0H/L0rGNewU2xJGf
         ieGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AD7B22E03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Balbir Singh <bsingharora@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.16 081/113] powerpc/mce: Fix a bug where mce loops on memory UE.
Date: Mon, 30 Apr 2018 12:24:52 -0700
Message-Id: <20180430184018.603869231@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200600844926211?=
X-GMAIL-MSGID: =?utf-8?q?1599200600844926211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

commit 75ecfb49516c53da00c57b9efe48fa3f5504a791 upstream.

The current code extracts the physical address for UE errors and then
hooks it up into memory failure infrastructure. On successful
extraction of physical address it wrongly sets "handled = 1" which
means this UE error has been recovered. Since MCE handler gets return
value as handled = 1, it assumes that error has been recovered and
goes back to same NIP. This causes MCE interrupt again and again in a
loop leading to hard lockup.

Also, initialize phys_addr to ULONG_MAX so that we don't end up
queuing undesired page to hwpoison.

Without this patch we see:
  Severe Machine check interrupt [Recovered]
    NIP: [000000001002588c] PID: 7109 Comm: find
    Initiator: CPU
    Error type: UE [Load/Store]
      Effective address: 00007fffd2755940
      Physical address:  000020181a080000
  ...
  Severe Machine check interrupt [Recovered]
    NIP: [000000001002588c] PID: 7109 Comm: find
    Initiator: CPU
    Error type: UE [Load/Store]
      Effective address: 00007fffd2755940
      Physical address:  000020181a080000
  Severe Machine check interrupt [Recovered]
    NIP: [000000001002588c] PID: 7109 Comm: find
    Initiator: CPU
    Error type: UE [Load/Store]
      Effective address: 00007fffd2755940
      Physical address:  000020181a080000
  Memory failure: 0x20181a08: recovery action for dirty LRU page: Recovered
  Memory failure: 0x20181a08: already hardware poisoned
  Memory failure: 0x20181a08: already hardware poisoned
  Memory failure: 0x20181a08: already hardware poisoned
  Memory failure: 0x20181a08: already hardware poisoned
  Memory failure: 0x20181a08: already hardware poisoned
  Memory failure: 0x20181a08: already hardware poisoned
  ...
  Watchdog CPU:38 Hard LOCKUP

After this patch we see:

  Severe Machine check interrupt [Not recovered]
    NIP: [00007fffaae585f4] PID: 7168 Comm: find
    Initiator: CPU
    Error type: UE [Load/Store]
      Effective address: 00007fffaafe28ac
      Physical address:  00002017c0bd0000
  find[7168]: unhandled signal 7 at 00007fffaae585f4 nip 00007fffaae585f4 lr 00007fffaae585e0 code 4
  Memory failure: 0x2017c0bd: recovery action for dirty LRU page: Recovered

Fixes: 01eaac2b0591 ("powerpc/mce: Hookup ierror (instruction) UE errors")
Fixes: ba41e1e1ccb9 ("powerpc/mce: Hookup derror (load/store) UE errors")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/mce_power.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -441,7 +441,6 @@ static int mce_handle_ierror(struct pt_r
 					if (pfn != ULONG_MAX) {
 						*phys_addr =
 							(pfn << PAGE_SHIFT);
-						handled = 1;
 					}
 				}
 			}
@@ -532,9 +531,7 @@ static int mce_handle_derror(struct pt_r
 			 * kernel/exception-64s.h
 			 */
 			if (get_paca()->in_mce < MAX_MCE_DEPTH)
-				if (!mce_find_instr_ea_and_pfn(regs, addr,
-								phys_addr))
-					handled = 1;
+				mce_find_instr_ea_and_pfn(regs, addr, phys_addr);
 		}
 		found = 1;
 	}
@@ -572,7 +569,7 @@ static long mce_handle_error(struct pt_r
 		const struct mce_ierror_table itable[])
 {
 	struct mce_error_info mce_err = { 0 };
-	uint64_t addr, phys_addr;
+	uint64_t addr, phys_addr = ULONG_MAX;
 	uint64_t srr1 = regs->msr;
 	long handled;
 
