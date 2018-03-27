Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iJBv+TEEOuxr4VwIcGbzlxza71gnYr865LOjkg+MjAH+fi6mxgz9qbnSuRvKjmSUwIgk0
ARC-Seal: i=1; a=rsa-sha256; t=1522168307; cv=none;
        d=google.com; s=arc-20160816;
        b=M/HwL9lefi7906Sbfm9dwQmbfCqUvq5AFQejnECqVZ/QD/JoTVUsEz1oUSmiQ61Yzz
         NX2TxU8n+irvJbE9+zVC+oX+zVqDyfumftQkkr6gfKH15TS6YNI1Tg7mUnBfaCYjuuKU
         YzQq4ie2U8337mfe+5esqIr0OovXo8vIafNlTqhc4WJRMNqqOL/gDBomULQihbVq0D5a
         6c8RRFHdc8kgYtVUgTOapEw9u1bOzlKFLbuNKn+Zcu2XWAYStZuBe101pJub1KhHbGpA
         5OcrZI4H//RxtgvpNmLlOaGZj/zv1lucY+4DDQx0JnhbqkISX2WY5ZEDoQm8gOWBdjkX
         3/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SjuThd0ww9QUEYsUQQfOK1YrVAABBtTnNHuprhVQt6c=;
        b=QcVDLiFTvn32YoXE7rGcxrJY4v9QhmNqRdjXvpO5hzLNr7Dv3ONVeL+9IAQh4A1IpM
         atVT81KehDYeX2s/F3Kn+f2gIfUsuR6uWMFDVpj7+WqRXxJW+Ywjziy3J80C2li0uycj
         4QVDcVdbIBToviTohLHNmKB2kp0PgX86Sp9zMsIBAZqyA/udMpPFoucISW//hQbraH90
         14EnL2Sb11kJhuevKn2Tol5+noAZk//tIMXvMgFEVN1xbhB1+mBzSPtibzyffGu0ad7P
         MAsEoSDP9xGlS69PW/2ZPvEUwactPBb1hsMpzykkTycidrDW2x3GeewVz7OEuvPlfTC7
         Qjmg==
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
Subject: [PATCH 4.9 32/67] acpi, numa: fix pxm to online numa node associations
Date: Tue, 27 Mar 2018 18:27:24 +0200
Message-Id: <20180327162728.768009842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109003178035543?=
X-GMAIL-MSGID: =?utf-8?q?1596109154639131149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 
