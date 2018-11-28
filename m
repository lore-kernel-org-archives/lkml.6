Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE9DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6FD2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="a/+iXty8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6FD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeK2Kr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:29 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:55187 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbeK2Kr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=IVQVJsxbuowAbd/yxJNd0DNFSGZunvv8p3kE/MEcu70=; b=a/+iXty8h/PL
        IA2ExFqwt3yM3bLLXv2WP1ap1tCC3LIkG77a0sWVSs9oJstn8FOLBGOQFOweG/Ff0JobPbbD5rKK+
        rVtre/GBZWbWsxb+cxldMzWIRdzaAtp7GTxxM28g9VTTz/4oNaiLwzGO+C5sK4ylOqtYJXzB9EjG2
        tW98FrG+/0J1DvlgJa/c7lTf4ANUiqmDKC8VjDxOrlKC0iOqwTTVPlmWMyf4qS2ULit8xUBcY9yRL
        s/EN6Nx9yZkrceDX4iUrURACZP5QmoOV9u7LfQBVYSDlHIg1nqaxlJbgvnAylHliFFVSVf16bxadi
        xSOOgPIj3PyNdodwVgo8gA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Ur-0001zT-He; Thu, 29 Nov 2018 00:43:57 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 43E0AC16D1;
        Thu, 29 Nov 2018 00:43:42 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 04/27] lockdep tests: Run lockdep tests a second time under Valgrind
Date:   Wed, 28 Nov 2018 15:43:02 -0800
Message-Id: <20181128234325.110011-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5pAc/85ACmEzY6vCUC+7SEN602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aUspLOb
 hWoJxYN4NM6Du6hjq2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi2wFVccsCAZ2dyI5DAR
 qfkZNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkCLb5mum9xAXSaS3KKPtTZXWZip9+GhedmPokL8D3vhvY6dhwYzYMxd
 D9vfHZcjDv9O+eyolGM4l8rlxuGfhU+3NYPzMyldJaF5xZTjcWEFHpu0VYQwuqxmozzkDLIpUMoG
 SJj2/VGV7PqOahGXkaU4twU/8XGrHu5QsNBEHc0tEDNi5zR1WYi0E09NG6GB18n4mJSlGpCLjjP2
 TVCcvwpqZ1ubF9nsHFY+fq7mKwOLapPtRVkPryfKs6DA7QYq3G1BRp7ylSZxUEGgJw4nFzgd7yt3
 7BfpyvvZ6l+boZNfkk++GRKi3fJfRTPr/PuJHE36okpX82/BtXToloueSaXs0TK8OQ3cB9QF11y7
 2DRSHKQElPJyNJdgFsJFEs/93MUqyw4EGsT5SRZt/MSyWzDH5AnI+wExEi2ZXZcwFmj/G9G9XUMB
 gNDO+NkNGowFW+REN2PQUubU67h4IQuWPMZ4HKssSJVidkER7VZq4yeVz8oBMMMFnt8VzQUPDSXZ
 uD7+tXK85NWt4CYBo2l7vp9TheM8Ply7UNk9s+JR29DmIqQBJ7TPMihJUfmPOEFZaWOoGwSHnDFQ
 4P4YDtlBXByrTecUvjKvjZONtLXg4KjauZafx+OvKcOyQvUosS9CO/I=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves test coverage.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/run_tests.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index 38b8c9034b8e..f1b5027925db 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -30,3 +30,17 @@ find tests -name '*.c' | sort | while read -r i; do
 	fi
 	rm -f "tests/$testname"
 done
+
+find tests -name '*.c' | sort | while read -r i; do
+	testname=$(basename "$i" .c)
+	echo -ne "(PRELOAD + Valgrind) $testname... "
+	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
+		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
+		"tests/${testname}.sh" < "tests/${testname}.vg.out" &&
+		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
+		echo "PASSED!"
+	else
+		echo "FAILED!"
+	fi
+	rm -f "tests/$testname"
+done
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

