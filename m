Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184472-2-500435472263782610
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184471; b=PMoDQAaq1vYstUVMXj2DNefKCTWQQfT0FZ1FbAakqw1Kexj
    DP8Womw2UvvcI4n0IvDd+oPy6PkwKxVKTZ6T1WGgUkPiLL3cR5qRKPgHqZuiv87n
    MRE0M7uuFCYyh6SjQz5/l0qAJlTYIc1r/edNWbi6CLhPwUZD92lXbxDvSGrpSbx8
    Lv+kbizYL2a6G6sjPYLQt+9T9EuK4/VBIgZDaCPt3mL9jr85I8o6q9wS8cBY5B26
    9WaJfAuK8tPper54j4tN/2HNLTaCKCm/PAOIiDdMJWRbD3G7Su8W/vth0hFJqhQo
    WWkhclm0JuWr7lCT+yvdBM02Y+FtzqNWs4zBbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184471; bh=rlwzqN9COqSJKnJBZ6R6ZZvf1x
    3Mm3mtqGe8l+w3QWY=; b=eFRuuK/R2pHVH5t1P0RFfqwHOTvZP7d4noP/LKN8EJ
    /ghUwyztgm+qhB2YjHdAP4SdQPZcYvsE//G0Su2Qebnj2yLKEsX8C6qpuEnZ0FRg
    Te38t4JOgXvVSyYkKw99DAoczsQfZlCti+1zm/mabgpSwoXtmiyNZWt2j1BM86Bs
    O90Pft4vEBYd3G8WaexMEk3X+rJV5+hGZUDMXX+crsxurDHVbOk8xxtI+u9nVZpD
    Pt0AkM7BeY8Endse3Hd+zTXkDjvZzB4QDQVNCjl9P1vmSfL8JrEUcEcMNgnv70ni
    TG046ODfj/Z9otkhnvfX2jdq0jMwI1/bB5MO/Jxk/Evg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeBINpq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932095AbeBINpl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4.14 03/22] kbuild: rpm-pkg: keep spec file until make mrproper
Date: Fri,  9 Feb 2018 14:39:52 +0100
Message-Id: <20180209133934.282959969@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit af60e207087975d069858741c44ed4f450330ac4 upstream.

If build fails during (bin)rpm-pkg, the spec file is not cleaned by
anyone until the next successful build of the package.

We do not have to immediately delete the spec file in case somebody
may want to take a look at it.  Instead, make them ignored by git,
and cleaned up by make mrproper.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 .gitignore               |    5 +++++
 scripts/package/Makefile |    4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,11 @@ modules.builtin
 /Module.markers
 
 #
+# RPM spec file (make rpm-pkg)
+#
+/*.spec
+
+#
 # Debian directory (make deb-pkg)
 #
 /debian/
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -50,7 +50,6 @@ rpm-pkg rpm: FORCE
 	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
 	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
 	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE) -ta $(KERNELPATH).tar.gz
-	rm $(KERNELPATH).tar.gz kernel.spec
 
 # binrpm-pkg
 # ---------------------------------------------------------------------------
@@ -59,7 +58,8 @@ binrpm-pkg: FORCE
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
 		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
-	rm binkernel.spec
+
+clean-files += $(objtree)/*.spec
 
 # Deb target
 # ---------------------------------------------------------------------------
