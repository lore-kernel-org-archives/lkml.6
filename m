Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226E/j1GCQ54b+nNW7shmf+lMT3LPiWdAHhyu8jLzPyT3okc0JX1hq3Gzft/6N9PV7nVFoEH
ARC-Seal: i=1; a=rsa-sha256; t=1519218464; cv=none;
        d=google.com; s=arc-20160816;
        b=duKP/nbxwCweybg3cT/ZuYHxzzhTCZ8szBDdSHTHbll7/kQIDfWyngR6Lyf0gnnfU4
         aT51UT4vS6+4NWyvqdsMAbYdBandhWObaaXmIy4D1bM4LYsacXttPMFEaB4KNW4GClvJ
         9bZYlWlIO2aNpwImTj22OXarqwfU8Yn9QZYO5K4uYxG9HeVYeci/OEZDuTpcbSVB89Y0
         8t3bUUqfl+bXFDew3zPyfIY49LmskZt28DtyG30yVP50oO+HtYp3vPM+WjjtZJp00z8u
         /1gyqq2bjJJqHaevoFy2XEYTRZnlKjSgW7O7CvmQobooGIwXWXpAln0BTsUVE5kB6t70
         ROVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RuA5c/LmOFURFp+guAoyZjASXZin3YZa/GPEnNsM0c0=;
        b=rV5iVujrIoWeOtESxJUqG3p1L040OySxdVJZRA77zsSQpKSjMyxc5KNlqLlg+dG7nr
         N+nTAYWfeubkzJCHnFaBgbMuxKzm+3tKBvQswry25ZLw/AlpDkWJOzRKJoMrSpyWhluA
         YXG3s6S64m5S1EBPLskCYOjGgitiTJ9zy7AQLe4om006rfVyhde9qcPnVRkMRzjJDe/F
         sfZy3zJP+7fXtFC9XS5W7M9H6j8JUglK16XbRlWLz4DZVgkDSsij10FjdgDGeqqHzeG8
         P8K4QNAA1Q4tU3dCsRBTspKYQ7kRX6NaXUfICVqkbDE3jC8MF/nZZrZsazJrDn6vRvg6
         OzJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.15 021/163] powerpc/vas: Dont set uses_vas for kernel windows
Date: Wed, 21 Feb 2018 13:47:30 +0100
Message-Id: <20180221124531.343806093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016020843689294?=
X-GMAIL-MSGID: =?utf-8?q?1593016020843689294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit b00b62898631b756c3e123542bbb0487aa343dd9 upstream.

cp_abort is only required for user windows, because kernel context
must not be preempted between a copy/paste pair.

Without this patch, the init task gets used_vas set when it runs the
nx842_powernv_init initcall, which opens windows for kernel usage.

used_vas is then never cleared anywhere, so it gets propagated into
all other tasks. It's a property of the address space, so it should
really be cleared when a new mm is created (or in dup_mmap if the
mmaps are marked as VM_DONTCOPY). For now we seem to have no such
driver, so leave that for another patch.

Fixes: 6c8e6bb2a52d ("powerpc/vas: Add support for user receive window")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/vas-window.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/powerpc/platforms/powernv/vas-window.c
+++ b/arch/powerpc/platforms/powernv/vas-window.c
@@ -1063,16 +1063,16 @@ struct vas_window *vas_tx_win_open(int v
 			rc = PTR_ERR(txwin->paste_kaddr);
 			goto free_window;
 		}
+	} else {
+		/*
+		 * A user mapping must ensure that context switch issues
+		 * CP_ABORT for this thread.
+		 */
+		rc = set_thread_uses_vas();
+		if (rc)
+			goto free_window;
 	}
 
-	/*
-	 * Now that we have a send window, ensure context switch issues
-	 * CP_ABORT for this thread.
-	 */
-	rc = -EINVAL;
-	if (set_thread_uses_vas() < 0)
-		goto free_window;
-
 	set_vinst_win(vinst, txwin);
 
 	return txwin;
