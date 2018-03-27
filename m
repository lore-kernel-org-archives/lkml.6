Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/R9J7ivvnbUk81fszo0NW1FfGYnfqa2OElU6p5Ky06CkTNNThJgyw0/UlcncWxaDetU8JY
ARC-Seal: i=1; a=rsa-sha256; t=1522168601; cv=none;
        d=google.com; s=arc-20160816;
        b=rI8HW3ZhoaY2LUAFddYHsVe+qbs6VsvUSCzU8FY/TwCDKLwrR1sNzATJXWzY8W17Y5
         6XViqLCwvBtC0RA5UjimHCv56eET0BO1EIM+N2KnPVPM7TWqrFea1/HanCrndYXkdoVL
         60UL3nVpR6qIWzhdsX4XA9T9Tey89vHnH4BOxBoTsIF/hjfGAIfcxhoJjRP8wbM87YC7
         T/cKwBQlRnu91vilUZtiTzqWjLkRUIS7f2mPo5Sex0gmIl2ycZT1lyVL1YOoKcm7Fg6s
         FdmEzfQateUt4keMrFhDlMRIa+IpCqm2XI2WYzThxjCYReirvxP/zHlod8cKsd6OguxA
         s59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bKYpPzv6vHl4a5LzKJllNQ58AKGnZ4b3dt0fwjPvaWE=;
        b=ly1sG4DQLcvhM8xDr0X+ipt8VKMEc0UUo/uP7WgDMSDWjpo1x47etx8wHfOk13PsDe
         inOSG0hL0Jtx9zWVsC3NotSaDNB6C1lp33Qs8E9KTNzB6+jBzlaWxPggAca49xkrQdO9
         aA4dnjaHIVlQOZ+I0SeCRfaxzuCrAj7P0x5xSP5mNLyMTIk+my1v5W0zeqZfCndSdiyV
         ZA3i0h5qFd+QKMWydrYgYDgRE5KFOrRUQCa7ufsJa84lDw8ORfOgS33VCetDdDFfOZHT
         QQWkU6dk90oFsxhVyxQps/Q8sp460sR3QVspsGFW0us2WKpu3ZJV5TbwSUbiFuX5zfxd
         WuPQ==
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
Subject: [PATCH 4.14 059/101] acpi, numa: fix pxm to online numa node associations
Date: Tue, 27 Mar 2018 18:27:31 +0200
Message-Id: <20180327162753.623173436@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109003178035543?=
X-GMAIL-MSGID: =?utf-8?q?1596109463219070848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
