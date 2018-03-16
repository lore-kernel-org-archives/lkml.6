Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuRjLynDaPE4xctTOBr+E+KDiHd1bySPlNI155COtafBWxxmqdvUAPKVzmmp5DyBcGNR0pj
ARC-Seal: i=1; a=rsa-sha256; t=1521215085; cv=none;
        d=google.com; s=arc-20160816;
        b=cWZ/HsLtBQY/lPjqTLkDaSbeo27il9mriVoU3Wy0tKFgdUAksBx8NV1tsiVxl0NlyD
         kcs4pI/NlAiZmy+X4kjtBtc5vOnuEdgfXx+o9URWTgW4rjkkYrmpsSrPivnJ7NplNctq
         X5U1BGQ9r1OXyZM326RLKt8bmwZstXD1EGFvME0I7jsyaYY7WMsMOqGFSrG/Jhby7cBC
         2TYqxo0W+zpvOWOrSWgePf/1USek5aqHGULiy60tD8KF/yV10Hi99YC+KozfjEvtc0SF
         XTTpbsXAFu90GQzjJlGF4XBSbECa38OLsBlr/vyOn8rnmFBjmEeyVsLxD6i2I5vXE84q
         0xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=syFgWdKGeStMahP8DTHF2hNMTy4rvb5Pl9GxH3GDYRk=;
        b=cLaBjQrObrOeDkLEYYQHXrfE7lb6nf2Rq4b3yoiJ6JXFvhFbrufNIxmhDkEwT3lanz
         hO+8QN+sQWco13JSJlB0kHcGHTIu9toMs1msgHO5FCwIJahurxKDZc3Btsm6ubAygBem
         W//dgIIwIzexDffkWGboFHUEcYEA96VWerycK378a83n4Wz2FZuTowq0FtJ5lRO2m+Vx
         OLuQDZJIYguydeo+ZBHEu5P0QdPSBtYqJVMiRZ0Pj5nD+geThI0exSLNLv6CD6Jlp8uw
         eziOBWJQ2zegKKtMtrgUYFmKEXwPLZWDR8ndVicErioCtakM7p/QJ5ciCpE1tz6OGoAa
         nxug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
	Mika Kuoppala <mika.kuoppala@intel.com>,
	drm-intel-fixes@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 115/128] agp/intel: Flush all chipset writes after updating the GGTT
Date: Fri, 16 Mar 2018 16:24:16 +0100
Message-Id: <20180316152342.225086171@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109222877537471?=
X-GMAIL-MSGID: =?utf-8?q?1595109629182417549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 8516673a996870ea0ceb337ee4f83c33c5ec3111 ]

Before accessing the GGTT we must flush the PTE writes and make them
visible to the chipset, or else the indirect access may end up in the
wrong page. In commit 3497971a71d8 ("agp/intel: Flush chipset writes
after updating a single PTE"), we noticed corruption of the uploads for
pwrite and for capturing GPU error states, but it was presumed that the
explicit calls to intel_gtt_chipset_flush() were sufficient for the
execbuffer path. However, we have not been flushing the chipset between
the PTE writes and access via the GTT itself.

For simplicity, do the flush after any PTE update rather than try and
batch the flushes on a just-in-time basis.

References: 3497971a71d8 ("agp/intel: Flush chipset writes after updating a single PTE")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: drm-intel-fixes@lists.freedesktop.org
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171208214616.30147-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/agp/intel-gtt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -872,6 +872,8 @@ void intel_gtt_insert_sg_entries(struct
 		}
 	}
 	wmb();
+	if (intel_private.driver->chipset_flush)
+		intel_private.driver->chipset_flush();
 }
 EXPORT_SYMBOL(intel_gtt_insert_sg_entries);
 
