Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+6zBAp5gK8rzYy7mFsqNVD2/7YGVf3xYcnZdxDmIHzAw/6DWnSZ07g5fpm+VAa6IxAhxkr
ARC-Seal: i=1; a=rsa-sha256; t=1522168880; cv=none;
        d=google.com; s=arc-20160816;
        b=JFZ4u+UpCH5pnFOvNpIVLHtkViYI/eUiG8QQ5YTGUtIoEP7Ag/kl52aD/uifHxk5rK
         mh80hji350keVGPFGHrjjk9sLLDb5z9k++nGxnkSfQBrQOgqLniCpAFyAMFgDBVLdcGt
         JPcKbVo5N+UabOKC0efZsMsr5VWbIRjK0PVIKQSahU81AyKumImr2DHCMWUzNPrR5Zck
         1+M5uTCPf7NjRCN6VnxZaJerO8G3V9uCeQU/3mHNwcEA1G/bcjcmVmY7FSwvgURt/iKt
         fIraemzgcrJxe0yPztxPdHEI1XT1X1OJ+/esUVKYBJlSp+EKYOmiPzWUS4HyCCMMBfq+
         HSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CPMBtzRX+7jq8U9ThrWW30FhDbrAG6QN71vEusk4qE4=;
        b=LWFgEsTGlNq8zUN/REaZCQYXnMXTUcrOuFhLX5UIErIpUOsU2KhX7g5NcvYNoMIjnw
         eoASNlN2jBumQz54LMjV6jp9EZ7AeNGQI0DFwN1rc4oz2K8eN4zE0mEhrSZ+zh2gZGfb
         zBzq1CgM9Ncc4mlOUOKRUJqAqgA/e+hDyW36odFaz60nov2k5cs1Fu4wtgeQRsthARsi
         p7RnWtXf+t0rE+2EqnA1PQHRyFEa5KsFsn6FS1CRGNh8sIEaj66cZbzZ/qeGg9f2KCRe
         RyoKCCpC7kbNxukEEBRtzp1m663OuzkJW1aONvne59ZbFdNToBiHbtaH1TiOSElLQ4cL
         A7Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshi Kani <toshi.kani@hp.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.15 064/105] acpi, numa: fix pxm to online numa node associations
Date: Tue, 27 Mar 2018 18:27:44 +0200
Message-Id: <20180327162801.592218766@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109003178035543?=
X-GMAIL-MSGID: =?utf-8?q?1596109756033553059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit dc9e0a9347e932e3fd3cd03e7ff241022ed6ea8a upstream.

Commit 99759869faf1 "acpi: Add acpi_map_pxm_to_online_node()" added
support for mapping a given proximity to its nearest, by SLIT distance,
online node. However, it sometimes returns unexpected results due to the
fact that it switches from comparing the PXM node to the last node that
was closer than the current max.

    for_each_online_node(n) {
            dist = node_distance(node, n);
            if (dist < min_dist) {
                    min_dist = dist;
                    node = n;	<---- from this point we're using the
				      wrong node for node_distance()


Fixes: 99759869faf1 ("acpi: Add acpi_map_pxm_to_online_node()")
Cc: <stable@vger.kernel.org>
Reviewed-by: Toshi Kani <toshi.kani@hp.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/numa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -103,25 +103,27 @@ int acpi_map_pxm_to_node(int pxm)
  */
 int acpi_map_pxm_to_online_node(int pxm)
 {
-	int node, n, dist, min_dist;
+	int node, min_node;
 
 	node = acpi_map_pxm_to_node(pxm);
 
 	if (node == NUMA_NO_NODE)
 		node = 0;
 
+	min_node = node;
 	if (!node_online(node)) {
-		min_dist = INT_MAX;
+		int min_dist = INT_MAX, dist, n;
+
 		for_each_online_node(n) {
 			dist = node_distance(node, n);
 			if (dist < min_dist) {
 				min_dist = dist;
-				node = n;
+				min_node = n;
 			}
 		}
 	}
 
-	return node;
+	return min_node;
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
 
