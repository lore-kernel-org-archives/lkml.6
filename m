Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ynesyLRNBs8k0Ox7r/UxwtOWZXL1NMx81TrcL8VufWT7VkvSALO6Yn2Dy9AKYkqkawm6D
ARC-Seal: i=1; a=rsa-sha256; t=1519410973; cv=none;
        d=google.com; s=arc-20160816;
        b=GyvQ7b3MnS/DWCj/O3z0nuGekWMUrrZjvKCKLqXKm7d9TBTVxm5V2tGGEthvZSce7Z
         bhyNUyrBGnD1nS3IQtfeKnpll2hJd/veGVgi782sWSjxZbHMoJ9kVVirVfLB0BEfdhgW
         CEpJ3DZnmelFThYUB5U8/m6IX5FKpvTHD1Nf8/KvxaiUjlburop4F2wduAmiLFTB8xRc
         4DOyWMUpRf1aweY3uvbUzAxaWgiLBJUaHK8YzS9X2d80PHpZKol6RRwgJu17STvc7SU4
         xKDtrGbHci8/SfP5/4Zx7JriZinGJoyRlceT0JNLsL53BRVOf2VFQKZXWoSGwh2f9xKN
         Wr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hNy5E3dlVdS6mXaNDI43RJKpbdT5cqrqMD/qrOOy2nI=;
        b=q2V/Ea+M83d92jSf8ot8MzXhHb3jeRhyjGqP2RSJdaC64OEKkGxhdmeOZoovIkFpak
         hvGQol0bIxocU9/cuQ/1cUeZB18CsTk7ax/IEI8opuE2qrAhOpBiOY/Qj6qDDts5fs3X
         oJ2LubkrwoNkd+VGi+0Kesu1rNT2tg7WpDQQVCs9l8weLi0Gu4b//uDmlE1EPdgexwsP
         h8O0Mw3VpdxklL2bJbN+fLkxHJ7BL+q48wRtXz90uuTSEMPxDcJKagiEnloFW/nbUJ/D
         RbMXWIZAQdq0/HZMG+muMnZTT/30xc3uiGOQNDzuZCnPXqAWHQVrtmQ1r5K84+bNqrDb
         gNow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will.deacon@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 040/193] scripts/kernel-doc: Dont fail with status != 0 if error encountered with -none
Date: Fri, 23 Feb 2018 19:24:33 +0100
Message-Id: <20180223170332.306392622@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217612425405249?=
X-GMAIL-MSGID: =?utf-8?q?1593217880553828547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit e814bccbafece52a24e152d2395b5d49eef55841 ]

My bisect scripts starting running into build failures when trying to
compile 4.15-rc1 with the builds failing with things like:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:2078: error: Cannot parse struct or union!

The line in question is actually just a #define, but after some digging
it turns out that my scripts pass W=1 and since commit 3a025e1d1c2ea
("Add optional check for bad kernel-doc comments") that results in
kernel-doc running on each source file. The file in question has a
badly formatted comment immediately before the #define:

/**
 * struct brcmf_skbuff_cb reserves first two bytes in sk_buff::cb for
 * bus layer usage.
 */

which causes the regex in dump_struct to fail (lack of braces following
struct declaration) and kernel-doc returns 1, which causes the build
to fail.

Fix the issue by always returning 0 from kernel-doc when invoked with
-none. It successfully generates no documentation, and prints out any
issues.

Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kernel-doc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -2742,4 +2742,4 @@ if ($verbose && $warnings) {
   print STDERR "$warnings warnings\n";
 }
 
-exit($errors);
+exit($output_mode eq "none" ? 0 : $errors);
