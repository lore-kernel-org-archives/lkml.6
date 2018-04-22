Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mdjkPLmmS45Jh7PwEJVG5sAztuYwK5wnzYLUdjbNqfwe7QZXEJfq4mQyqD/Jb1z6xf43l
ARC-Seal: i=1; a=rsa-sha256; t=1524406053; cv=none;
        d=google.com; s=arc-20160816;
        b=z3Dc/2rvqYjL9pbTErnxM1x8rgJqPTmDQNbkm3U8YRluzH7i1dkPGR+jTRuvosw3Hk
         MdLdDSj5Ox/kQiwWr1C/kBU6JSRYoavCh8KlhwU0RfjUkrPDGRfAsKYehKORj3B8mjx3
         Sle6XddxZFrCoVKz58UwlLNR2hcly1N6cPUdxe86cZbK5YOr5pD7Di0b36hizv2R6N0Z
         XFQZRDRrchQkKB1FddrE0f3833I9e8EU9T0VhnZ/W7LplhkwHmslbixfnL3f2qN4ol6S
         v/iwIJUZGALLlJfRda5LhnjUazmVYx9Xhop46gmTBLAvhl6NNYYnzakhu5DOqMNX9xTO
         E8hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EU1C5+X+LZkE35ga5ltOCyWVxktD+nF6kk/wox7Hn4o=;
        b=X4S5VLIPff+qu2hXTNYd4WV1HmPLi1iWBriBbU5xZhsOD/yOb/18//mH4y8DRiNNmN
         4JxoV1VVI+k3DX5pY4TI+N4UV6+ZC9OwyswusOmfIZiUDKT3v8yrXfSDV+nRSmG0oJFq
         5o3WK8Fj0ZloImJj8jwoTFbkMGrJGuHQkpclsYJ4+L0dm18Z0/oEWr0q89c6tTeK9WKj
         r/8Og3UcWX4UYaMcvucfmpJjGvOfBywAH7alTS5tNdRS3JlFGK/ao0fEolaXjwltDOlo
         +j0SnmFflT9AfXXIH+fO1u0j2UACdznbBIOqszNjPgOXgux79itskM3LWyiYzp6Ho0p0
         7VcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Krzysztof Rusocki <krzysztof.rusocki@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 095/164] libnvdimm, dimm: fix dpa reservation vs uninitialized label area
Date: Sun, 22 Apr 2018 15:52:42 +0200
Message-Id: <20180422135139.313233127@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455217087202947?=
X-GMAIL-MSGID: =?utf-8?q?1598455601812546332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit c31898c8c711f2bbbcaebe802a55827e288d875a upstream.

At initialization time the 'dimm' driver caches a copy of the memory
device's label area and reserves address space for each of the
namespaces defined.

However, as can be seen below, the reservation occurs even when the
index blocks are invalid:

 nvdimm nmem0: nvdimm_init_config_data: len: 131072 rc: 0
 nvdimm nmem0: config data size: 131072
 nvdimm nmem0: __nd_label_validate: nsindex0 labelsize 1 invalid
 nvdimm nmem0: __nd_label_validate: nsindex1 labelsize 1 invalid
 nvdimm nmem0: : pmem-6025e505: 0x1000000000 @ 0xf50000000 reserve <-- bad

Gate dpa reservation on the presence of valid index blocks.

Cc: <stable@vger.kernel.org>
Fixes: 4a826c83db4e ("libnvdimm: namespace indices: read and validate")
Reported-by: Krzysztof Rusocki <krzysztof.rusocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/dimm.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -65,9 +65,11 @@ static int nvdimm_probe(struct device *d
 	ndd->ns_next = nd_label_next_nsindex(ndd->ns_current);
 	nd_label_copy(ndd, to_next_namespace_index(ndd),
 			to_current_namespace_index(ndd));
-	rc = nd_label_reserve_dpa(ndd);
-	if (ndd->ns_current >= 0)
-		nvdimm_set_aliasing(dev);
+	if (ndd->ns_current >= 0) {
+		rc = nd_label_reserve_dpa(ndd);
+		if (rc == 0)
+			nvdimm_set_aliasing(dev);
+	}
 	nvdimm_clear_locked(dev);
 	nvdimm_bus_unlock(dev);
 
